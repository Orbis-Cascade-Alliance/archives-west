<?php
// AW_OAI returns records for harvesting

class AW_OAI {
  
  public $metadata_prefix;
  public $verb;
  public $set;
  public $ark;
  public $from;
  public $until;
  public $resumption_token;
  private $arks;
  private $dc_records;
  private $finding_aid;
  private $repo;
  private $offset;
  private $dom;
  private $total;
  private $incomplete;
  private $all_repos;
  
  private $max_records;
  
  function __construct($verb, $metadata_prefix, $set) {
    $this->verb = $verb;
    $this->metadata_prefix = $metadata_prefix;
    if ($set) {
      $this->set_repo($set);
    }
    else {
      $this->set = null;
    }
    $this->ark = null;
    $this->from = null;
    $this->until = null;
    $this->resumption_token = null;
    $this->max_records = 100;
    $this->offset = 0;
    $this->incomplete = false;
    $this->all_repos = get_all_repos();
  }
  
  // Write standard errors to the DOMDocument
  // http://www.openarchives.org/OAI/openarchivesprotocol.html#ErrorConditions
  function write_error($error_code) {
    $messages = array(
      'badArgument' => 'A required argument is missing or invalid.',
      'badResumptionToken' => 'This resumptionToken is invalid or has expired.',
      'badVerb' => 'Illegal OAI verb.',
      'cannotDisseminateFormat' => 'Only oai_dc is supported.',
      'idDoesNotExist' => 'No finding aid with this ARK exists.',
      'noRecordsMatch' => 'No Archives West records match these arguments.'
    );
    $xml = $this->get_dom();
    $error = $xml->createElement('error', $messages[$error_code]);
    $code = $xml->createAttribute('code');
    $code->value = $error_code;
    $error->appendChild($code);
    $xml->documentElement->appendChild($error);
    
    // Remove any attributes added to the request node
    // Standard: "In cases where the request that generated this response resulted in a badVerb or badArgument error condition, the repository must return the base URL of the protocol request only. Attributes must not be provided in these cases."
    if ($error_code == 'badVerb' || $error_code == 'badArgument') {
      $request = $xml->getElementsByTagName('request')->item(0);
      while ($request->hasAttributes()) {
        $request->removeAttributeNode($request->attributes->item(0));
      }
    }
  }
  
  // Write a resumptionToken element to the DOMDocument for subsequent requests
  function write_resumption_token($parent) {
    if ($this->incomplete) {
      $xml = $this->get_dom();
      $current_offset = $this->get_offset();
      $next_offset = $current_offset + $this->get_max_records();
      $total = $this->total;
      
      // Add resumptionToken node to XML
      $resumptionToken = $xml->createElement('resumptionToken');
      $completeListSize = $xml->createAttribute('completeListSize');
      $completeListSize->value = $total;
      $resumptionToken->appendChild($completeListSize);
      $cursor = $xml->createAttribute('cursor');
      $cursor->value = $current_offset;
      $resumptionToken->appendChild($cursor);
      
      // Populate resumptionToken if this is not the last incomplete response
      if ($next_offset < $total) {
        $token = uniqid();
        $verb = $this->get_verb();
        $prefix = $this->get_metadata_prefix();
        $oai_set = $this->get_set();
        $date_from = $this->get_from();
        $date_until = $this->get_until();
        $one_hour = strtotime('+1 hour');
        $expiration = date('Y-m-d H:i:s', $one_hour);
        $gmt_expiration = gmdate('Y-m-d\TH:i:s\Z', $one_hour);

        // Save token to MySQL
        // "set" and "from" are reserved keywords, so they needed to be "oai_set" and "date_from" in the table
        // https://dev.mysql.com/doc/refman/8.0/en/keywords.html
        if ($mysqli = connect()) {
          $oai_stmt = $mysqli->prepare('INSERT INTO oai (token, offset, verb, prefix, oai_set, date_from, date_until, expiration) VALUES (?, ?, ?, ?, ?, ?, ?, ?)');
          $oai_stmt->bind_param('sissssss', $token, $next_offset, $verb, $prefix, $oai_set, $date_from, $date_until, $expiration);
          $oai_stmt->execute();
          if ($mysqli->error) {
            die($mysqli->error);
          }
          $mysqli->close();
        }
        
        // Add token and expiration to resumptionToken
        $resumptionToken->appendChild($xml->createTextNode($token));
        $expirationDate = $xml->createAttribute('expirationDate');
        $expirationDate->value = $gmt_expiration;
        $resumptionToken->appendChild($expirationDate);
      }
      $parent->appendChild($resumptionToken);
    }
  }
  
  // Return the XML result of a verb and arguments
  function get_result() {
    $xml = $this->get_dom();
    switch ($this->get_verb()) {
      case 'GetRecord':
        if ($this->get_metadata_prefix() == 'oai_dc') {
          if ($this->get_finding_aid()) {
            $record = $this->get_record();
            $GetRecord = $xml->createElement('GetRecord');
            $GetRecord->appendChild($record);
            $xml->documentElement->appendChild($GetRecord);
          }
        }
        else {
          $this->write_error('cannotDisseminateFormat');
        }
      break;
      case 'Identify':
        $Identify = $xml->createElement('Identify');
        $Identify->appendChild($xml->createElement('repositoryName', 'Archives West'));
        $Identify->appendChild($xml->createElement('baseURL', AW_DOMAIN));
        $Identify->appendChild($xml->createElement('protocolVersion', '2.0'));
        $Identify->appendChild($xml->createElement('adminEmail', 'webmaster@orbiscascade.org'));
        $Identify->appendChild($xml->createElement('earliestDatestamp', '2006-02-07T08:00:00Z'));
        $Identify->appendChild($xml->createElement('deletedRecord', 'persistent'));
        $Identify->appendChild($xml->createElement('granularity', 'YYYY-MM-DD'));
        $xml->documentElement->appendChild($Identify);
      break;
      case 'ListIdentifiers':
        if ($this->get_metadata_prefix() == 'oai_dc') {
          if (!$this->get_set() || $this->is_valid_set()) {
            $ListIdentifiers = $xml->createElement('ListIdentifiers');
            if ($all_arks = $this->get_arks()) {
              foreach ($all_arks as $ark) {
                $this->set_ark($ark);
                $header = $this->get_header();
                $ListIdentifiers->appendChild($header);
              }
            }
            $xml->documentElement->appendChild($ListIdentifiers);
            $this->write_resumption_token($ListIdentifiers);
          }
        }
        else {
          $this->write_error('cannotDisseminateFormat');
        }
      break;
      case 'ListMetadataFormats':
        $ListMetadataFormats = $xml->createElement('ListMetadataFormats');
        $metadataFormat = $xml->createElement('metadataFormat');
        $metadataFormat->appendChild($xml->createElement('metadataPrefix', 'oai_dc'));
        $metadataFormat->appendChild($xml->createElement('schema', 'http://www.openarchives.org/OAI/2.0/oai_dc.xsd'));
        $metadataFormat->appendChild($xml->createElement('metadataNamespace', 'http://www.openarchives.org/OAI/2.0/oai_dc/'));
        $ListMetadataFormats->appendChild($metadataFormat);
        $xml->documentElement->appendChild($ListMetadataFormats);
      break;
      case 'ListRecords':
        if ($this->get_metadata_prefix() == 'oai_dc') {
          if (!$this->get_set() || $this->is_valid_set()) {
            $ListRecords = $xml->createElement('ListRecords');
            foreach ($this->get_arks() as $ark) {
              $this->set_ark($ark);
              $ListRecords->appendChild($this->get_record());
            }
            $xml->documentElement->appendChild($ListRecords);
            $this->write_resumption_token($ListRecords);
          }
        }
        else {
          $this->write_error('cannotDisseminateFormat');
        }
      break;
      case 'ListSets':
        $all_repos = $this->all_repos;
        $ListSets = $xml->createElement('ListSets');
        foreach ($all_repos as $repo_id => $repo_info) {
          $set = $xml->createElement('set');
          $set->appendChild($xml->createElement('setSpec', $repo_info['mainagencycode']));
          $set->appendChild($xml->createElement('setName', $repo_info['name']));
          $ListSets->appendChild($set);
        }
        $xml->documentElement->appendChild($ListSets);
      break;
      default:
        if (count($xml->getElementsByTagName('error')) == 0) {
          $this->write_error('badVerb');
        }
      break;
    }
    return $xml->saveXML();
  }
  
  // Set resumption token for this response
  // Don't confuse with write_resumption_token, which creates a new token for the next response
  function set_resumption_token($token) {
    $this->resumption_token = $token;
    if ($mysqli = connect()) {
      $token_stmt = $mysqli->prepare('SELECT * FROM oai WHERE token=? AND expiration >= NOW()');
      $token_stmt->bind_param('s', $token);
      $token_stmt->execute();
      $token_results = $token_stmt->get_result();
      if ($token_results->num_rows == 1) {
        while ($token_row = $token_results->fetch_assoc()) {
          $this->offset = $token_row['offset'];
          $this->verb = $token_row['verb'];
          $this->metadata_prefix = $token_row['prefix'];
          $this->set_repo($token_row['oai_set']);
          $this->from = $token_row['date_from'];
          $this->until = $token_row['date_until'];
        }
      }
      else {
        $this->write_error('badResumptionToken');
      }
      $mysqli->close();
    }
  }
  
  function get_resumption_token() {
    return $this->resumption_token;
  }
  
  function get_metadata_prefix() {
    return $this->metadata_prefix;
  }
  
  function get_verb() {
    return $this->verb;
  }
  
  function get_set() {
    return $this->set;
  }
  
  function is_valid_set() {
    if (get_id_from_mainagencycode($this->get_set())) {
      return true;
    }
    else {
      return false;
    }
  }
  
  function set_ark($ark) {
    $this->ark = $ark;
    try {
      $finding_aid = new AW_Finding_Aid($ark);
      $this->finding_aid = $finding_aid;
    }
    catch (Exception $e) {
      if ($this->get_verb() == 'GetRecord') {
        $this->write_error('idDoesNotExist');
      }
    }
  }
  
  function get_ark() {
    return $this->ark;
  }
  
  function get_finding_aid() {
    return $this->finding_aid;
  }
  
  function set_from($from) {
    $this->from = $from;
  }
  
  function get_from() {
    return $this->from;
  }
  
  function set_until($until) {
    $this->until = $until;
  }
  
  function get_until() {
    return $this->until;
  }
  
  function get_max_records() {
    return $this->max_records;
  }
  
  // Set a new repository "set" for returning records
  // Sets are mainagencycodes
  function set_repo($set) {
    if ($set != null) {
      $this->set = strtolower($set);
      if ($repo_id = get_id_from_mainagencycode($set)) {
        $this->repo = new AW_Repo($repo_id);
        unset($this->arks);
        unset($this->dc_records);
        return true;
      }
      else {
        $this->write_error('badArgument');
      }
    }
    return false;
  }
  
  // Get the current repository
  function get_repo() {
    return $this->repo;
  }
  
  // Get offset for results
  function get_offset() {
    return $this->offset;
  }
  
  // Get ARKs with uploaded files for a given repository
  // Also sets a resumptionToken for results over 100
  function get_arks() {
    if (!isset($this->arks)) {
      $arks = array();
      $max_records = $this->get_max_records();
      if ($mysqli = connect()) {
        $ark_query = 'SELECT arks.ark, GREATEST(arks.date, COALESCE(updates.date, 0)) as greatest_date FROM arks LEFT JOIN updates ON arks.ark=updates.ark WHERE arks.file<>""';
        if ($ark = $this->get_ark()) {
          $ark_query .= ' AND arks.ark="' . $ark . '"';
        }
        if ($repo = $this->get_repo()) {
          $ark_query .= ' AND arks.repo_id=' . $repo->get_id();
        }
        if ($this->get_from() || $this->get_until()) {
          $having = array();
          if ($from = $this->get_from()) {
            $having[] = 'greatest_date >= "' . $from . '"';
          }
          if ($until = $this->get_until()) {
            $having[] = 'greatest_date <= "' . $until . '"';
          }
          $ark_query .= ' HAVING ' . implode(' AND ', $having);
        }
        $ark_query .= ' ORDER BY greatest_date ASC';
        
        // Run query to get total count
        $total_result = $mysqli->query($ark_query);
        if ($total_result->num_rows > 0) {
          if ($total_result->num_rows > $max_records) {
            $this->total = $total_result->num_rows;
            $this->incomplete = true;
          }
          // Apply limit to get records
          $ark_query .= ' LIMIT ' . $this->get_offset() . ',' . $max_records;
          $ark_result = $mysqli->query($ark_query);
          while ($ark_row = $ark_result->fetch_row()) {
            $arks[] = $ark_row[0];
          }
        }
        else {
          $this->write_error('noRecordsMatch');
        }
        $mysqli->close();
      }
      $this->arks = $arks;
    }
    return $this->arks;
  }
  
  // Return the root DOM element for the document, regardless of verb
  function get_dom() {
    if (!isset($this->dom)) {
      $xml = new DOMDocument("1.0", "UTF-8");
      $root = $xml->appendChild($xml->createElementNS('http://www.openarchives.org/OAI/2.0/', 'OAI-PMH'));
      $root->setAttributeNS('http://www.w3.org/2000/xmlns/', 'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
      $root->setAttributeNS('http://www.w3.org/2001/XMLSchema-instance', 'xsi:schemaLocation', 'http://www.openarchives.org/OAI/2.0/ http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd');
      $root->appendchild($xml->createElement('responseDate', gmdate('Y-m-d\TH:i:s\Z')));
      $request = $xml->createElement('request', AW_DOMAIN . '/oai.php');
      if ($this->get_verb()) {
        $verb = $xml->createAttribute('verb');
        $verb->value = $this->get_verb();
        $request->appendChild($verb);
      }
      if ($this->get_metadata_prefix()) {
        $metadataPrefix = $xml->createAttribute('metadataPrefix');
        $metadataPrefix->value = $this->get_metadata_prefix();
        $request->appendChild($metadataPrefix);
      }
      if ($this->get_resumption_token()) {
        $resumptionToken = $xml->createAttribute('resumptionToken');
        $resumptionToken->value = $this->get_resumption_token();
        $request->appendChild($resumptionToken);
      }
      $root->appendChild($request);
      $this->dom = $xml;
    }
    return $this->dom;
  }
  
  // Get a finding aid for ListRecords and GetRecord verbs
  // Returns DOMElement
  function get_record() {
    $xml = $this->get_dom();
    $record = $xml->createElement('record');
    $header = $this->get_header();
    $ark = $this->get_ark();
    $record->appendChild($header);
    if ($dc = $this->get_dc($ark)) {
      $metadata = $xml->createElement('metadata');
      $metadata->appendChild($dc);
      $record->appendChild($metadata);
    }
    return $record;
  }
  
  // Get record header for a finding aid
  // Returns DOMElement
  function get_header() {
    $ark = $this->get_ark();
    $xml = $this->get_dom();
    $finding_aid = $this->get_finding_aid();
    $header = $xml->createElement('header');
    $header->appendChild($xml->createElement('identifier', $ark));
    $header->appendChild($xml->createElement('datestamp', date('Y-m-d', strtotime($finding_aid->get_last_date()))));
    $header->appendChild($xml->createElement('setSpec', $finding_aid->get_repo()->get_mainagencycode()));
    // Add deleted status
    if (!$finding_aid->is_active()) {
      $status = $xml->createAttribute('status');
      $status->value = 'deleted';
      $header->appendChild($status);
    }
    return $header;
  }
  
  // Get Dublin Core metadata for a finding aid
  function get_dc($ark) {
    $dc_records = $this->get_dc_records();
    if (isset($dc_records[$ark])) {
      $xml = $this->get_dom();
      $dc = $xml->createElement('oai_dc:dc');
      $dc->setAttributeNS('http://www.w3.org/2000/xmlns/', 'xmlns:oai_dc', 'http://www.openarchives.org/OAI/2.0/oai_dc/');
      $dc->setAttributeNS('http://www.w3.org/2000/xmlns/', 'xmlns:dc', 'http://purl.org/dc/elements/1.1/');
      $dc->setAttributeNS('http://www.w3.org/2000/xmlns/', 'xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
      $dc->setAttributeNS('http://www.w3.org/2001/XMLSchema-instance', 'xsi:schemaLocation', 'http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd');
      
      // Get title, creator, subjects, languages, description, date, and identifier from XQuery
      $dc_record = $dc_records[$ark];
      $repo_id = $dc_record['repo_id'];
      $repo_name = $this->all_repos[$repo_id]['name'];
      $dc->appendchild($xml->createElement('dc:identifier', AW_DOMAIN . '/ark:/' . $ark));
      $dc->appendChild($xml->createElement('dc:type', 'archival_materials'));
      $dc->appendChild($xml->createElement('dc:source', 'Archives West'));
      $dc->appendChild($xml->createElement('dc:publisher', $repo_name));
      // Single elements
      $map = array(
        'title' => 'dc:title',
        'creator' => 'dc:creator',
        'abstract' => 'dc:description',
        'extent' => 'dc:format',
        'date' => 'dc:date'
      );
      foreach ($map as $key => $name) {
        if ($encoded_value = htmlspecialchars($dc_record[$key])) {
          $dc->appendChild($xml->createElement($name, $encoded_value));
        }
      }
      // Repeating elements
      $map2 = array(
        'languages' => 'dc:language',
        'subjects' => 'dc:subject'
      );
      foreach ($map2 as $key => $name) {
        foreach ($dc_record[$key] as $value) {
          if ($encoded_value = htmlspecialchars($value)) {
            $dc->appendChild($xml->createElement($name, $encoded_value));
          }
        }
      }
      return $dc;
    }
    else {
      return false;
    }
  }
  
  // Get DC information for all finding aids in this request from BaseX
  function get_dc_records() {
    if (!isset($this->dc_records)) {
      $records = array();
      if ($repo = $this->get_repo()) {
        $repo_ids = array($repo->get_id());
      }
      else {
        $repo_ids = array_keys(get_all_repos());
      }
      $session = new AW_Session();
      $query = $session->get_query('dublin-core.xq');
      $query->bind('d', implode('|', $repo_ids));
      $query->bind('a', implode('|', $this->get_arks()));
      $result_string = $query->execute();
      $query->close();
      $session->close();
      if ($result_string) {
        $result_xml = simplexml_load_string($result_string);
        foreach ($result_xml->children() as $record) {
          $ark = (string) $record->ark;
          $languages = array();
          foreach ($record->languages->language as $language) {
            $languages[] = $language;
          }
          $subjects = array();
          foreach ($record->subjects->subject as $subject) {
            $subjects[] = $subject;
          }
          $records[$ark] = array(
            'repo_id' => (string) $record->db,
            'title' => (string) $record->title,
            'date' => (string) $record->date,
            'creator' => (string) $record->creator,
            'subjects' => $subjects,
            'languages' => $languages,
            'abstract' => (string) $record->abstract,
            'extent' => (string) $record->extent
          );
        }
      }
      else {
        throw new Exception('REST response failed.');
      }
      $this->dc_records = $records;
    }
    return $this->dc_records;
  }

}
?>
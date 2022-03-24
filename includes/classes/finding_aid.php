<?php
// AW_Finding_Aid retrieves information about a finding aid from the MySQL database

class AW_Finding_Aid {
  
  public $id = 0;
  public $ark = '';
  private $qualifier = '';
  public $repo = 0; // AW_Repo object
  public $ark_file = ''; // String filename
  public $ark_date = ''; // String date
  public $last_date = ''; // String date from updates table
  public $ark_cached = 0; // Boolean cached
  public $ark_active = 0; // Boolean active
  private $xml; // SimpleXML object
  private $transformed; // String stylesheet-transformed XML
  public $title; // String finding aid title
  public $creator; // String finding aid creator
  public $cache_path; // Full path to the cached transformed file
  public $qr_code;
  
  function __construct($ark) {
    $this->ark = $ark;
    if ($mysqli = connect()) {
      $ark_query = 'SELECT arks.id, arks.ark, arks.file, arks.date, GREATEST(arks.date, COALESCE(max_updates.max_date, 0)) as last_date,
        arks.repo_id, arks.cached, arks.active FROM arks LEFT JOIN (
          SELECT ark, MAX(date) as max_date FROM updates GROUP BY ark
        ) as max_updates
        ON arks.ark=max_updates.ark
        WHERE arks.ark=?';
      $ark_stmt = $mysqli->prepare($ark_query);
      if ($mysqli->error) {
        die($mysqli->error);
      }
      $ark_stmt->bind_param('s', $ark);
      $ark_stmt->execute();
      if ($ark_result = $ark_stmt->get_result()) {
        if ($ark_result->num_rows == 1) {
          while ($ark_row = $ark_result->fetch_assoc()) {
            $this->id = $ark_row['id'];
            $repo_id = $ark_row['repo_id'];
            $this->repo = new AW_Repo($repo_id);
            $this->ark_file = $ark_row['file'];
            $this->ark_date = $ark_row['date'];
            $this->last_date = $ark_row['last_date'];
            $this->ark_cached = $ark_row['cached'];
            $this->ark_active = $ark_row['active'];
          }
        }
        else {
          throw new Exception('ARK ' . $ark . ' not found.');
        }
      }
      else {
        throw new Exception('Error in MySQL query.');
      }
      $mysqli->close();
    }
    else {
      throw new Exception('MySQL connection failed.');
    }
    $this->qualifier = substr($ark, 6);
    $this->cache_path = AW_REPOS . '/' . $this->get_repo()->get_folder() . '/cache/' . $this->get_qualifier() . '.html';
  }
  
  // Get ID
  function get_id() {
    return $this->id;
  }
  
  // Get ARK
  function get_ark() {
    return $this->ark;
  }
  
  // Get qualifier
  function get_qualifier() {
    return $this->qualifier;
  }
  
  // Get AW_Repo object
  function get_repo() {
    return $this->repo;
  }
  
  // Get file name
  function get_file() {
    return $this->ark_file;
  }
  
  // Get complete file path
  function get_filepath() {
    return AW_REPOS . '/' . $this->get_repo()->get_folder() . '/eads/' . $this->get_file();
  }
  
  // Get date
  function get_date() {
    return $this->ark_date;
  }
  
  // Get last update date
  function get_last_date() {
    return $this->last_date;
  }
  
  // Return cached value
  function is_cached() {
    return $this->ark_cached == 1 ? true : false;
  }
  
  // Return active value
  function is_active() {
    return $this->ark_active == 1 ? true : false;
  }
  
  // Get cache path
  function get_cache_path() {
    return $this->cache_path;
  }

  // Get cached file
  // Returns false if path does not exist, since transformations
  // can take a long time and will be done in the background
  function get_cache() {
    if (file_exists($this->cache_path)) {
      return file_get_contents($this->cache_path);
    }
    return false;
  }
  
  // Start the cache process for this finding aid
  function build_cache() {
    start_cache_process($this->get_ark());
  }
  
  // Delete the existing cache
  function delete_cache() {
    if (file_exists($this->cache_path)) {
      unlink($this->cache_path);
      if ($mysqli = connect()) {
        $mysqli->query('UPDATE arks SET cached=0 WHERE ark="' . $this->get_ark() . '"');
        $mysqli->close();
      }
    }
  }
  
  // Get raw XML file
  // Removes the submission date element in publicationstmt
  function get_raw() {
    $xml = simplexml_load_file($this->get_filepath());
    unset($xml->xpath('//eadheader/filedesc/publicationstmt/date[@type="archiveswest"]')[0][0]);
    return $xml->asXml();
  }
  
  // Get DOMDocument of XML file
  function get_xml() {
    if (!isset($this->xml)) {
      if (file_exists($this->get_filepath()) && is_file($this->get_filepath())) {
        $this->xml = simplexml_load_file($this->get_filepath());
      }
      else {
        $this->xml = null;
      }
    }
    return $this->xml;
  }
  
  // Transform XML
  function transform() {
    if (!isset($this->transformed)) {
      if ($this->get_file()) {
        $filepath = $this->get_filepath();
        $repo = $this->get_repo();
        if ($xml = $this->get_xml()) {

          // Add contact and license info from repos table
          $additions_xml = $xml->addChild('aw-additions');
          $additions_xml->addChild('rights', $repo->get_rights());
          $repo_xml = $additions_xml->addChild('repository');
          $repo_xml->addchild('name', $repo->get_name());
          $repo_xml->addChild('url', $repo->get_url());
          $address_xml = $repo_xml->addChild('address');
          $l = 1;
          foreach ($repo->get_address() as $line) {
            $address_xml->addChild('line' . $l, $line);
            $l++;
          }
          $repo_xml->addChild('phone', $repo->get_phone());
          $repo_xml->addChild('fax', $repo->get_fax());
          $repo_xml->addChild('email', $repo->get_email());

          // Get XSL
          $xsl = new DOMDocument;
          $xsl->load(AW_HTML . '/xsl/nwda_0.1.xsl');

          // Process
          $proc = new XSLTProcessor();
          $proc->importStyleSheet($xsl);
          $transformed = $proc->transformToXML($xml);
          $stripped_transformed = preg_replace('/<!DOCTYPE[^>]+>[\n\r]/', '', $transformed);
          if ($stripped_transformed) {
            $this->transformed = $stripped_transformed;
          }
          else {
            throw new Exception('Transformation of ' . $filepath . ' is empty.');
          }
        }
        else {
          throw new Exception('File ' . $filepath . ' does not exist.');
        }
      }
      else {
        throw new Exception('File is not set for this ARK.');
      }
    }
    return $this->transformed;
  }
  
  function get_value($node) {
    if ($node) {
      if (count($node->children()) == 0) {
        return (string) $node;
      }
      else {
        return (string) $node->children()[0];
      }
    }
  }
  
  // Get title from BaseX
  function get_title() {
    if (!isset($this->title)) {
      $session = new AW_Session();
      $query = $session->get_query('get-export.xq');
      $query->bind('d', $this->get_repo()->get_id());
      $query->bind('a', $this->get_ark());
      $result_string = $query->execute();
      $query->close();
      $session->close();
      if ($result_string) {
        $result_xml = simplexml_load_string($result_string);
        $this->title = (string) $result_xml->ead->title;
      }
    }
    return $this->title;
  }
  
  // Get QR code SVG file
  function get_qr_code() {
    if (!isset($this->qr_code)) {
      $qr_file = $this->get_qualifier() . '.svg';
      $qr_path = $this->get_repo()->get_folder() . '/qr/' . $qr_file;
      if (!file_exists($qr_path)) {
        exec('zint -b QRCODE -o ' . AW_REPOS . '/' . $qr_path . ' -d "' . AW_DOMAIN . '/ark:/' . $this->get_ark() . '" --scale 4');
      }
      $this->qr_code = AW_DOMAIN . '/repos/' . $qr_path;
    }
    return $this->qr_code;
  }
}
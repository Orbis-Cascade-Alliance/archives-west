<?php
// Functions for converting, validating, checking compliance for, and uploading contents of files

// Strip namespaces from root
function strip_namespaces($xml_string) {
  $new_string = preg_replace('/<ead [^>]+>/', '<ead>', $xml_string);
  $new_string = preg_replace('/xlink:type/', 'linktype', $new_string);
  $new_string = preg_replace('/xlink:/', '', $new_string);
  $new_string = preg_replace('/\sxsi:[^"]+"[^"]+"/', '', $new_string);
  return $new_string;
}

// Add DTD declaration, if missing
function add_dtd($xml_string) {
  if (!stristr($xml_string, '<!DOCTYPE')) {
    return str_replace('<ead>','<!DOCTYPE ead PUBLIC "+//ISBN 1-931666-00-8//DTD ead.dtd (Encoded Archival Description (EAD) Version 2002)//EN" "https://archiveswest.orbiscascade.org/ead.dtd">' . "\r\n\r\n" . '<ead>', $xml_string);
  }
  return $xml_string;
}

// Add submission date to publicationstmt
function add_submission_date($xml_string, $time) {
  if ($xml = simplexml_load_string($xml_string)) {
    unset($xml->xpath('//eadheader/filedesc/publicationstmt/date[@type="archiveswest"]')[0][0]);
    $date = $xml->eadheader->filedesc->publicationstmt->addChild('date', date('F j, Y', $time));
    $date->addAttribute('type', 'archiveswest');
    $date->addAttribute('normal', date('Ymd', $time));
    $date->addAttribute('era', 'ce');
    $date->addAttribute('calendar', 'gregorian');
    return $xml->asXML();
  }
  else {
    return false;
  }
}

// Rename c nodes in as2aw conversion
function rename_c($c, $ead) {
  $c_level = 1;
  $parent_node = $c->parentNode;
  if (substr($parent_node->tagName, 0, 2) == 'c0') {
    $parent_level = (int) substr($parent_node->tagName, 2);
    $c_level = $parent_level + 1;
  }
  $new_c = $ead->createElement('c0' . $c_level);
  if ($level = $c->getAttribute('level')) {
    $new_c->setAttribute('level', $level);
  }
  if ($c->hasChildNodes()) {
    for ($i = 0; $i < count($c->childNodes); $i++) {
      $child = $c->childNodes->item($i);
      $new_child = $child->cloneNode(true);
      $new_c->appendChild($new_child);
      if ($new_child->tagName == 'c') {
        rename_c($new_child, $ead);
      }
    }
  }
  $c->parentNode->replaceChild($new_c, $c);
}

// Convert file contents from ArchivesSpace to Archives West EAD
function convert_file($file_contents, $mainagencycode) {
  $errors = array();
  $converted_ead = '';
  
  // Remove namespaces
  $ead_string = strip_namespaces($file_contents);
  
  // String to DOM
  set_error_handler(function($number, $error){
    if (preg_match('/^DOMDocument::loadXML\(\): (.+)$/', $error, $m) === 1) {
      throw new Exception($m[1]);
      restore_error_handler();
    }
  });
  try {
    $ead = new DOMDocument('1.0', 'utf-8');
    $ead->preserveWhiteSpace = false;
    $ead->formatOutput = true;
    $ead->loadXML($ead_string);
  }
  catch (Exception $e) {
    $errors[] = $e->getMessage();
  }
  restore_error_handler();
  
  if (empty($errors)) {
  
    // Add DOCTYPE with DTD
    if (!stristr($ead_string, '<!DOCTYPE')) {
      $implementation = new DOMImplementation();
      $doctype = $implementation->createDocumentType('ead', '+//ISBN 1-931666-00-8//DTD ead.dtd (Encoded Archival Description (EAD) Version 2002)//EN', 'ead.dtd');
      $ead->insertBefore($doctype, $ead->documentElement);
    }
    
    // Create Xpath
    $xpath = new DOMXpath($ead);
    
    // Check EADID
    if ($eadid = $xpath->query('//eadheader/eadid')->item(0)) {

      // Remove globally unwanted attributes
      foreach (array('audience', 'label', 'datechar', 'parent') as $attribute) {
        foreach ($xpath->query('//*[@' . $attribute . ']') as $node) {
          $node->removeAttribute($attribute);
        }
      }
      
      // Remove IDs from all nodes except Aeon external references
      foreach ($xpath->query('//*[@id]') as $node) {
        if ($node->getAttribute('id') != 'aeon') {
          $node->removeAttribute('id');
        }
      }
      
      // Remove specific unwanted attributes
      $to_remove = array(
        '//eadheader' => 'findaidstatus',
        '//archdesc//physdesc' => 'altrender',
        '//archdesc//physdesc//extent' => 'altrender'
      );
      foreach ($to_remove as $query => $attribute) {
        foreach($xpath->query($query . '[@' . $attribute . ']') as $node) {
          $node->removeAttribute($attribute);
        }
      }
      
      // Remove daogrps (until Archives West supports Digital Object harvesting)
      foreach ($xpath->query('//did/daogrp') as $daogrp) {
        $daogrp->parentNode->removeChild($daogrp);
      }
      
      // Rewrite attribute values to lowercase
      $to_convert = array(
        '//container' => 'type',
        '//extref' => 'actuate',
        '//dao' => 'actuate'
      );
      foreach ($to_convert as $query => $attribute) {
        foreach ($xpath->query($query . '[@' . $attribute . ']') as $node) {
          $value = $node->getAttribute($attribute);
          $lower_value = strtolower($value);
          if ($attribute == 'type') {
            $lower_value = preg_replace('/\s+/', '-', $lower_value);
          }
          $node->removeAttribute($attribute);
          if ($lower_value) {
            $node->setAttribute($attribute, $lower_value);
          }
        }
      }
      
      // Add new attributes
      $to_add = array(
        '//eadheader' => array(
          'relatedencoding' => 'dc',
          'scriptencoding' => 'iso15924'
        ),
        '//eadheader/eadid' => array(
          'identifier' => extract_ark($eadid->getAttribute('url')),
          'mainagencycode' => $mainagencycode
        ),
        '//archdesc' => array(
          'relatedencoding' => 'marc21',
          'type' => 'inventory'
        ),
        '//archdesc/did/unitid' => array(
          'countrycode' => $eadid->getAttribute('countrycode'),
          'repositorycode' => $mainagencycode
        ),
        '//archdesc//controlaccess/subject[@source="archiveswest"]' => array(
          'altrender' => 'nodisplay'
        )
      );
      foreach ($to_add as $query => $attributes) {
        foreach ($xpath->query($query) as $node) {
          foreach ($attributes as $name => $value) {
            $node->removeAttribute($name);
            $node->setAttribute($name, $value);
          }
        }
      }
      
      // Dsc: add type attribute and add digits to names of <c> elements
      // Reiterative function to nest <c> is at the bottom of this file
      $levels = array(
          'class' => 'analyticover',
          'collection' => 'analyticover',
          'file' => 'in-depth',
          'fonds' => 'analyticover',
          'item' => 'in-depth',
          'otherlevel' => 'othertype',
          'recordgrp' => 'analyticover',
          'series' => 'analyticover',
          'subgrp' => 'analyticover',
          'subseries' => 'analyticover'
        );
        foreach ($xpath->query('//dsc') as $dsc) {
          if ($dsc->hasChildNodes()) {
            $types = array();
            foreach ($dsc->childNodes as $c) {
              $type = '';
              $level = $c->getAttribute('level');
              if (isset($levels[$level])) {
                $type = $levels[$level];
              }
              if ($type && !in_array($type, $types)) {
                $types[] = $type;
              }
            }
            if (count($types) > 1) {
              $dsc->setAttribute('type', 'combined');
            }
            else {
              if (!empty($types)) {
                $dsc->setAttribute('type', $types[0]);
              }
            }
          }
          else {
            $dsc->parentNode->removeChild($dsc);
          }
        }
        foreach ($xpath->query('//dsc/c') as $c) {
          rename_c($c, $ead);
        }
      
      // Rewrite incorrect role attribute values
      foreach ($xpath->query('//*[@role]') as $node) {
        $role = $node->getAttribute('role');
        if (stristr($role, ' (')) {
          $split_role = explode(' (', $role);
          $role = $split_role[0];
        }
        $lower_role = strtolower($role);
        $node->removeAttribute('role');
        $node->setAttribute('role', $lower_role);
      }
      
      // Change source "naf" to "lcnaf"
      foreach (array('persname', 'corpname') as $type) {
        foreach ($xpath->query('//' . $type) as $node) {
          if ($node->getAttribute('source') == 'naf') {
            $node->removeAttribute('source');
            $node->setAttribute('source', 'lcnaf');
          }
        }
      }
      
      // Address: extract URL only in last line
      if ($last_line = $xpath->query('//eadheader//address/addressline[last()]')->item(0)) {
        if ($extptr = $last_line->getElementsByTagName('extptr')->item(0)) {
          $url = $extptr->getAttribute('href');
          $new_last_line = $ead->createElement('addressline', $url);
          $address = $last_line->parentNode;
          $address->removeChild($last_line);
          $address->appendChild($new_last_line);
        }
      }
      
      // Titlestmt: Reorder children
      foreach ($xpath->query('//eadheader/filedesc/titlestmt') as $titlestmt) {
        $titleproper = $titlestmt->getElementsByTagName('titleproper');
        if (count($titleproper) > 1) {
          $titlestmt->appendChild($titleproper->item(1));
          $titlestmt->appendChild($titleproper->item(0));
        }
        foreach (array('author', 'sponsor') as $child_type) {
          $children = $titlestmt->getElementsByTagName($child_type);
          foreach ($children as $child) {
            $titlestmt->appendChild($child);
          }
        }
        $encodinganalog = $ead->createAttribute('encodinganalog');
        $encodinganalog->value = 'title';
        $titleproper->item(0)->appendChild($encodinganalog);
      }
      
      // Titleproper: remove call number and add altrender
      $titleproper_query = $xpath->query('//titleproper');
      foreach ($titleproper_query as $titleproper) {
        if ($callnumber = $titleproper->getElementsByTagName('num')->item(0)) {
          $titleproper->removeChild($callnumber);
        }
        if ($titleproper->getAttribute('type') == 'filing') {
          $titleproper->setAttribute('altrender', 'nodisplay');
        }
        $titleproper->nodeValue = trim(htmlentities($titleproper->nodeValue));
      }
      
      // First titleproper: copy archdesc/did/unitdate into new date element
      $date_clone = $xpath->query('//archdesc/did/unitdate')->item(0)->cloneNode();
      $titleproper_query->item(0)->appendChild($date_clone);
      $renamed_clone = $ead->createElement('date');
      foreach ($date_clone->attributes as $attribute) {
        $renamed_clone->setAttribute($attribute->nodeName, $attribute->nodeValue);
      }
      while ($date_clone->firstChild) {
        $renamed_clone->appendChild($date_clone->firstChild);
      }
      $date_clone->parentNode->replaceChild($renamed_clone, $date_clone);
      
      // Publicationstmt: Remove <p> and normalize date
      foreach ($xpath->query('//eadheader//publicationstmt') as $publicationstmt) {
        foreach ($xpath->query('//eadheader//publicationstmt/p/date') as $date) {
          $date->setAttribute('encodinganalog', 'date');
          $date->setAttribute('calendar', 'gregorian');
          $date->setAttribute('era', 'ce');
          $date_value = $date->nodeValue;
          preg_match_all('/[0-9]{4}/', $date_value, $year_matches);
          if (isset($year_matches[0])) {
            $normalized_year = implode('/', $year_matches[0]);
            $date->setAttribute('normal', $normalized_year);
          }
          $publicationstmt->replaceChild($date, $date->parentNode);
        }
      }
      
      // Profiledesc: rewrite date to Y-m-d and add language
      $date = $xpath->query('//eadheader//profiledesc/creation/date')->item(0);
      $date->nodeValue = date('Y-m-d', strtotime($date->nodeValue));
      if ($langusage = $xpath->query('//eadheader/profiledesc/langusage[not(language)]')->item(0)) {
        $language = $ead->createElement('language', $langusage->nodeValue);
        foreach (array('langcode' => 'eng', 'scriptcode' => 'latn', 'encodinganalog' => 'language') as $name => $value) {
          $language_attribute = $ead->createAttribute($name);
          $language_attribute->value = $value;
          $language->appendChild($language_attribute);
        }
        $new_langusage = $ead->createElement('langusage');
        $new_langusage->appendChild($language);
        $profiledesc = $langusage->parentNode;
        $profiledesc->removeChild($langusage);
        $profiledesc->appendChild($profiledesc->getElementsByTagName('creation')->item(0));
        $profiledesc->appendChild($new_langusage);
        $profiledesc->appendChild($profiledesc->getElementsByTagName('descrules')->item(0));
      }
      else if ($language = $xpath->query('//eadheader/profiledesc/langusage/language[not(@encodinganalog)]')->item(0)) {
        $language_attribute = $ead->createAttribute('encodinganalog');
        $language_attribute->value = 'language';
        $language->appendChild($language_attribute);
      }
      
      // Descrules: Change old notice to new notice
      $descrules = $xpath->query('//descrules')->item(0);
      if ($descrules->nodeValue == 'Describing Archives: A Content Standard') {
        $descrules->nodeValue = 'Finding aid based on DACS (Describing Archives: A Content Standard), 2nd Edition.';
      }
      
      // Origination: Collapse multiple nodes into one
      $origination_nodes = $xpath->query('//archdesc/did/origination');
      $origination_count = count($origination_nodes);
      if ($origination_count > 1) {
        $first_node = $origination_nodes->item(0);
        for ($o = 1; $o < $origination_count; $o++) {
          $node = $origination_nodes->item($o);
          foreach ($node->childNodes as $child) {
            $first_node->appendChild($child);
          }
          $node->parentNode->removeChild($node);
        }
      }
      
      // Physdesc: Rewrite extent to lowercase
      foreach ($xpath->query('//physdesc/extent') as $extent) {
        $extent->nodeValue = strtolower($extent->nodeValue);
      }
      
      // Archdesc: Change <dao> to <daogrp>
      foreach ($xpath->query('//archdesc//dao') as $dao) {
        $daogrp = $ead->createElement('daogrp');
        // resource
        $resource = $ead->createElement('resource');
        $resource->setAttribute('label', 'start');
        $daogrp->appendChild($resource);
        // daoloc
        $daoloc = $ead->createElement('daoloc');
        $daoloc->setAttribute('label', 'icon');
        $daoloc->setAttribute('role', 'text/html');
        if ($title = $dao->getAttribute('title')) {
          $daoloc->setAttribute('title', $title);
        }
        if ($href = $dao->getAttribute('href')) {
          $daoloc->setAttribute('href', $href);
        }
        $daogrp->appendChild($daoloc);
        // arc
        $arc = $ead->createElement('arc');
        $arc->setAttribute('from', 'start');
        $arc->setAttribute('to', 'icon');
        if ($show = $dao->getAttribute('show')) {
          $arc->setAttribute('show', $show);
        }
        if ($actuate = $dao->getAttribute('actuate')) {
          $arc->setAttribute('actuate', strtolower($actuate));
        }
        $daogrp->appendChild($arc);
        $dao->parentNode->replaceChild($daogrp, $dao);
      }
      
      // Controlaccess: remove whitespace from headings and separate into nested children
      if ($controlaccess = $xpath->query('//controlaccess')->item(0)) {
        $headings = $controlaccess->childNodes;
        $headings_by_type = array();
        foreach ($headings as $heading) {
          $type = $heading->tagName;
          if ($type == 'subject') {
            if ($heading->getAttribute('source') == 'archiveswest') {
              $type = 'subject-aw';
            }
          }
          $heading->nodeValue = str_replace(' -- ', '--', htmlentities($heading->nodeValue));
          $headings_by_type[$type][] = $heading;
        }
        foreach (array('persname', 'corpname', 'famname', 'geogname', 'subject', 'subject-aw', 'function', 'genreform', 'occupation', 'title') as $type) {
          $new_controlaccess = $ead->createElement('controlaccess');
          if (isset($headings_by_type[$type])) {
            foreach ($headings_by_type[$type] as $heading) {
              $new_controlaccess->appendChild($heading);
            }
            $controlaccess->appendChild($new_controlaccess);
          }
        }
      }
      
      // Add encodinganalog attributes
      $upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      $lower = 'abcdefghijklmnopqrstuvwxyz';
      $encodinganalogs = array(
        '//eadheader/eadid' => 'identifier',
        '//eadheader//author' => 'creator',
        '//eadheader//sponsor' => 'contributor',
        '//eadheader//publisher' => 'publisher',
        '//eadheader//publicationstmt/p/date' => 'date',
        '//archdesc//repository/corpname' => '852$a',
        '//archdesc//repository/subarea' => '852$b',
        '//archdesc//origination/persname' => '100',
        '//archdesc//origination/corpname' => '110',
        '//archdesc//origination/famname' => '100',
        '//archdesc//unittitle' => '245$a',
        '//archdesc//unitdate[@type=\'inclusive\']' => '245$f',
        '//archdesc//abstract' => '5203_',
        '//archdesc//langmaterial[1]/language' => '546',
        '//archdesc//bioghist[substring(translate(head/text(), "' . $upper . '", "' . $lower . '"), 1, 17)="biographical note"]' => '5450_',
        '//archdesc//bioghist[substring(translate(head/text(), "' . $upper . '", "' . $lower . '"), 1, 15)="historical note"]' => '5451_',
        '//archdesc//bioghist[not(@encodinganalog)]' => '545',
        '//archdesc//scopecontent' => '5202_',
        '//archdesc//odd' => '500',
        '//archdesc//arrangement' => '351',
        '//archdesc//altformavail' => '530',
        '//archdesc//accessrestrict' => '506',
        '//archdesc//userestrict' => '540',
        '//archdesc//prefercite' => '524',
        '//archdesc//custodhist' => '561',
        '//archdesc//acqinfo' => '541',
        '//archdesc//accruals' => '584',
        '//archdesc//separatedmaterial' => '5440_',
        '//archdesc//otherfindaid' => '555',
        '//archdesc//relatedmaterial' => '5441_',
        '//archdesc//controlaccess/subject[@source!="archiveswest"]' => '650',
        '//archdesc//controlaccess/subject[@source="archiveswest"]' => '690',
        '//archdesc//controlaccess/persname[not(@role!="")]' => '600',
        '//archdesc//controlaccess/persname[@role!=""]' => '700',
        '//archdesc//controlaccess/corpname[not(@role!="")]' => '610',
        '//archdesc//controlaccess/corpname[@role!=""]' => '710',
        '//archdesc//controlaccess/famname[not(@role!="")]' => '600',
        '//archdesc//controlaccess/famname[@role!=""]' => '700',
        '//archdesc//controlaccess/geogname' => '651',
        '//archdesc//controlaccess/genreform' => '655',
        '//archdesc//controlaccess/occupation' => '656',
        '//archdesc//controlaccess/function' => '657',
        '//unitdate[@type="bulk"]' => '245$g',
        '//physdesc/extent' => '300$a',
        '//archdesc//did/unitid' => '099'
      );
      foreach ($encodinganalogs as $query => $encodinganalog) {
        foreach ($xpath->query($query) as $node) {
          $attribute = $ead->createAttribute('encodinganalog');
          $attribute->value = $encodinganalog;
          $node->appendChild($attribute);
        }
      }
      
      // Convert anchor tags to extref
      foreach ($xpath->query('//a') as $anchor) {
        $extref = $anchor->ownerDocument->createElement('extref');
        foreach ($anchor->childNodes as $child){
          $extref->appendChild($anchor->ownerDocument->importNode($child, true));
        }
        foreach($anchor->attributes as $attrName => $attrNode) {
          $extref->setAttribute($attrNode->nodeName, $attrNode->nodeValue);
        }
        $anchor->parentNode->replaceChild($extref, $anchor);
      }
      
      // Remove <head> elements
      foreach ($xpath->query('//head') as $head) {
        $head->parentNode->removeChild($head);
      }
      
      // Remove empty <prefercite> elements
      foreach ($xpath->query('//prefercite[not(normalize-space())]') as $empty) {
        $empty->parentNode->removeChild($empty);
      }
      
      // Remove <unitid> elements with type "aspace_uri" added in 3.5.1
      foreach ($xpath->query('//unitid[@type="aspace_uri"]') as $aspace_unitid) {
        $aspace_unitid->parentNode->removechild($aspace_unitid);
      }
      
      // DOM to string
      $converted_ead = $ead->saveXML();
    }
    else {
      $errors[] = 'EADID not found.';
    }
  }
  return array('ead'=>$converted_ead, 'errors'=>$errors);
}

// Validate file contents
function validate_file($file_contents, $repo_id) {
  $errors = array();
  $ark = '';
  $file_contents = strip_namespaces($file_contents);
  $file_contents = add_dtd($file_contents);
  
  // Check loading errors
  libxml_use_internal_errors(true);
  $doc = new DOMDocument;
  $doc->loadXML($file_contents);
  $errors = add_errors($errors, libxml_get_errors());
  if (!$errors) {
    // Check validation
    if (!$doc->validate()) {
      $errors = add_errors($errors, libxml_get_errors());
    }
    else {
      // Check ARK in file against the ARK submitted
      $eadid = $doc->getElementsByTagName('eadid');
      if ($eadid->length == 0) {
        $errors[] = 'EADID element not found.';
      }
      else if ($eadid->length > 1) {
        $errors[] = 'More than one EADID element found.';
      }
      else {
        $ark = (string) $eadid->item(0)->getAttribute('identifier');
        if ($ark == '') {
          $errors[] = 'EADID identifier attribute not found.';
        }
        else{
          if ($mysqli = connect()) {
            $ark_stmt = $mysqli->prepare('SELECT repo_id FROM arks WHERE ark=?');
            $ark_stmt->bind_param('s', $ark);
            $ark_stmt->execute();
            $ark_result = $ark_stmt->get_result();
            if ($ark_result->num_rows == 0) {
              $errors[] = 'The ARK in this file does not match any database entries. View valid ARKs in the table on the main page and correct the identifier in the EADID element.';
            }
            else if ($ark_result->num_rows > 1) {
              $errors[] = 'The ARK in this file matches multiple ARK database entries. Contact <a href="mailto:webmaster@orbiscascade.org">webmaster@orbiscascade.org</a> to report the issue.';
            }
            else {
              while ($ark_row = $ark_result->fetch_row()) {
                $ark_repo_id = $ark_row[0];
                if ($ark_repo_id != $repo_id) {
                  $errors[] = 'The ARK in this file is associated with another institution. View valid ARKs in the table on the main page.';
                }
              }
            }
            $ark_stmt->close();
            $mysqli->close();
          }
        }
      }
    }
  }
  return array('ark'=>$ark, 'errors'=>$errors);
}

// Generate a compliance report for file contents
function check_compliance($file_contents, $all) {
  // Load and validate XML
  $errors = array();
  $file_contents = strip_namespaces($file_contents);
  if (trim($file_contents) != '') {
    libxml_use_internal_errors(true);
    $doc = new DOMDocument;
    $doc->loadXML($file_contents);
    $errors = add_errors($errors, libxml_get_errors());
    if (!$errors) {
      // Get XSL
      $xsl = new DOMDocument;
      $xsl->load(AW_TOOLS . '/xsl/bpg.xsl');

      // Process
      $proc = new XSLTProcessor();
      $proc->importStyleSheet($xsl);
      $proc->setParameter('axsl', 'all', $all);
      $transformed_xml = $proc->transformToXml($doc);
      $errors = add_errors($errors, libxml_get_errors());
    }
  }
  else {
    $errors[] = 'File is empty.';
  }
  return array('report'=>$transformed_xml, 'errors'=>$errors);
}

// Upload contents of a file
function upload_file($file_contents, $file_name, $ark, $replace, $user_id) {
  $errors = array();
  if ($ark) { 
    // Get existing finding aid information
    $current_finding_aid = new AW_Finding_Aid($ark);
    $repo = $current_finding_aid->get_repo();
    $repo_id = $repo->get_id();
    
    // Modify file name
    $to_replace = array(' ');
    $replacements = array('_');
    $file_name = str_replace($to_replace, $replacements, strtolower($file_name));
    
    // Build file path
    $repo_path = AW_REPOS . '/' . $repo->get_folder() . '/eads';
    $file_path = $repo_path . '/' . $file_name;
    
    // If file with the same name exists, check if it's for the current ARK or a different one
    $upload = true;
    // If this ARK is associated with a deleted file, print error
    if (!$current_finding_aid->is_active()) {
      $errors[] = 'This ARK is associated with a deleted finding aid. Submit a help request to restore the file.';
      $upload = false;
    }
    // If a file name exists in the database and we're not replacing it, print error
    else if ($current_finding_aid->get_file() && !$replace) {
      $errors[] = 'This ARK is associated with the file <strong>' . $current_finding_aid->get_file() . '</strong>.';
      $upload = false;
    }
    else if (file_exists($file_path)) {
      $associated_ark = '';
      if ($mysqli = connect()) {
        $ark_result = $mysqli->query('SELECT ark FROM arks WHERE file="' . $file_name . '" AND repo_id=' . $repo_id . ' AND active=1');
        if ($ark_result->num_rows == 1) {
          while ($ark_row = $ark_result->fetch_row()) {
            $associated_ark = $ark_row[0];
          }
        }
        $mysqli->close();
      }
      if ($associated_ark) {
        // If the file with the same name is for the same ARK and we're not replacing it, print error
        if ($associated_ark == $ark && !$replace) {
          $errors[] = 'A file with this name already exists for this ARK.';
          $upload = false;
        }
        // If the file with the same name is for a different ARK, print error whether we're replacing or not
        else if ($associated_ark != $ark) {
          $errors[] = 'A file with the name <strong>' . $file_name . '</strong> is associated with <a href="' . AW_DOMAIN . '/ark:/' . $associated_ark . '" target="_blank">' . $associated_ark . '</a>. Change the file name and try again.';
          $upload = false;
        }
      }
    }

    if ($upload) {
      // Check ARK in file against the ARK submitted
      libxml_use_internal_errors(true);
      $xml = simplexml_load_string($file_contents);
      if ($xml !== FALSE) {
        $current_file_name = '';
        if ($ark_in_file = (string) $xml->eadheader->eadid['identifier']) {
          $trimmed_ark_in_file = trim($ark_in_file);
          if ($trimmed_ark_in_file != $ark) {
            $errors[] = 'The ARK in the submitted file, <strong>' . $trimmed_ark_in_file . '</strong>, doesn\'t match the ARK selected.';
          }
          else {
            // If replacing...
            if ($replace) {
              $current_file_name = $current_finding_aid->get_file();
              // If file name is currently blank, set $replace to 0
              // Replace could be 1 in a batch job where uploaded files are new
              if ($current_file_name == '') {
                $replace = 0;
              }
              // If new file name is different, remove old file
              else if ($file_name != $current_file_name) {
                $current_file_path = $repo_path . '/' . $current_file_name;
                if (file_exists($current_file_path)) {
                  unlink($current_file_path);
                }
              }
            }
            
            // Strip namespaces and add submission date
            $stripped_string = strip_namespaces($file_contents);
            $new_string = add_submission_date($stripped_string, time());
            
            // Save the new file
            $fh = fopen($file_path, 'w');
            fwrite($fh, $new_string);
            fclose($fh);
            chmod($file_path, 0644);
            
            if (file_exists($file_path)) {
              if ($mysqli = connect()) {
                // Update arks table
                $update_stmt = $mysqli->prepare('UPDATE arks SET file=? WHERE ark=?');
                $update_stmt->bind_param('ss', $file_name, $ark);
                $update_stmt->execute();
                $update_stmt->close();
                
                // Insert into updates table
                $action = $replace ? 'replace' : 'add';
                $existing_result = $mysqli->query('SELECT id FROM updates WHERE ark="' . $ark . '" AND action="' . $action . '" AND complete=0');
                if ($existing_result->num_rows == 0) {
                  $insert_stmt = $mysqli->prepare('INSERT INTO updates (user, action, ark) VALUES (?, ?, ?)');
                  $insert_stmt->bind_param('iss', $user_id, $action, $ark);
                  $insert_stmt->execute();
                  $insert_stmt->close();
                }
                $mysqli->close();
              }
              
              // Update BaseX document database
              try {
                $session = new AW_Session();
                if ($replace) {
                  $session->replace_document($repo_id, $current_file_name, $file_name);
                }
                else {
                  $session->add_document($repo_id, $file_name);
                }
                $session->close();
              }
              catch (Exception $e) {
                log_error($e->getMessage());
                $errors[] = 'Error communicating with BaseX to upate document.';
              }
              
              // Save file in AWS S3
              require_once(AW_INCLUDES . '/classes/s3.php');
              foreach (S3_BUCKETS as $bucket) {
                try {
                  $s3 = new AW_S3($bucket['name'], $bucket['region'], $bucket['class'], $bucket['path']);
                  $s3->put_source($repo->get_folder() . '/' . $file_name, $file_path);
                }
                catch (Exception $e) {
                  log_error($e->getMessage());
                  $errors[] = 'Error archiving file in AWS.';
                }
              }
              
              // Start caching process
              $finding_aid = new AW_Finding_Aid($ark);
              if ($replace) {
                $finding_aid->delete_cache();
              }
              $finding_aid->build_cache();
              
              // Generate QR code
              $finding_aid->get_qr_code();
              
            }
            else {
              $errors[] = 'File could not be saved to repository.';
            }
          }
        }
        else {
          $errors[] = 'ARK not found in identifier attribute of eadheader/eadid.';
        }
      }
      else {
        $xml_errors = 'XML is invalid. See details below.<ul>';
        foreach (libxml_get_errors() as $xml_error) {
          $xml_error_message = (string) $xml_error->message;
          $xml_errors .= '<li>' . $xml_error_message . '</li>';
        }
        $xml_errors .= '</ul>';
        $errors[] = $xml_errors;
        libxml_clear_errors();
      }
    }
  }
  else {
    $errors[] = 'ARK is required.';
  }
  return array('errors'=>$errors);
}
?>
<?php
// Get user from session variable
function get_session_user($admin_only = false) {
  if (isset($_SESSION['user'])) {
    $user = $_SESSION['user'];
    if ($admin_only && !$user->is_admin()) {
      die('This tool is for use by admins only.');
    }
    else {
      return $user;
    }
  }
  else {
    die('Access forbidden.');
  }
}

// Get repository id
function get_user_repo_id($user) {
  $repo_id = 0;
  if ($user->is_admin()) {
    $repo_id = $_SESSION['repo_id'];
  }
  else {
    $repo_id = $user->get_repo_id();
  }
  return $repo_id;
}

// Add libxml error messages to an array
function add_errors($errors, $libxml_errors) {
  foreach ($libxml_errors as $libxml_error) {
    $errors[] = $libxml_error->message;
  }
  return $errors;
}

// Print an errors list
function print_errors($error_key) {
  ob_start();
  echo '<ul class="errors">';
  foreach ($_SESSION[$error_key] as $error) {
    echo '<li>' . $error . '</li>';
  }
  echo '</ul>';
  $error_list = ob_get_contents();
  ob_end_clean();
  return $error_list;
}

// Strip namespaces from root
function strip_namespaces($xml_string) {
  $new_string = preg_replace('/<ead [^>]+>/', '<ead>', $xml_string);
  $new_string = preg_replace('/xlink:/', '', $new_string);
  $new_string = preg_replace('/\sxsi:[^"]+"[^"]+"/', '', $new_string);
  return $new_string;
}

// Add DTD declaration, if missing
function add_dtd($xml_string) {
  if (!stristr($xml_string, '<!DOCTYPE')) {
    return str_replace('<ead>','<!DOCTYPE ead PUBLIC "+//ISBN 1-931666-00-8//DTD ead.dtd (Encoded Archival Description (EAD) Version 2002)//EN" "http://archiveswest.orbiscascade.org/ead.dtd">' . "\r\n\r\n" . '<ead>', $xml_string);
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

// Get ARK from a string
function extract_ark($string) {
  $ark = '';
  preg_match('|80444\/xv\d{5,6}|', $string, $matches);
  if (isset($matches[0])) {
    $ark = $matches[0];
  }
  return $ark;
}

// Get job types
function get_job_types() {
  return array('batch' => 'Batch Upload', 'as' => 'ArchivesSpace Import');
}

// Create a new job in MySQL
function create_job($job_type, $repo_id) {
  $job_id = null;
  if ($mysqli = connect()) {
    $insert_stmt = $mysqli->prepare('INSERT INTO jobs (type, repo_id) VALUES(?, ?)');
    $insert_stmt->bind_param('si', $job_type, $repo_id);
    $insert_stmt->execute();
    $insert_stmt->close();
    $job_id = $mysqli->insert_id;
    $mysqli->close();
  }
  return $job_id;
}

// Return a select element of ARKs
function build_ark_select($repo_id, $active = 1, $null_file = 0) {
  $ark_select = null;
  if ($mysqli = connect()) {
    $query = 'SELECT ark FROM arks WHERE repo_id=' . $repo_id . ' AND active=' . $active;
    if ($null_file) {
      $query .= ' AND file IS NULL';
    }
    $empty_result = $mysqli->query($query);
    if ($empty_result->num_rows > 0) {
      ob_start();
      echo '<select name="ark">';
      while ($empty_row = $empty_result->fetch_row()) {
        echo '<option value="' . $empty_row[0] . '">' . $empty_row[0] . '</option>';
      }
      echo '</select>';
      $ark_select = ob_get_contents();
      ob_end_clean();
    }
    $mysqli->close();
  }
  return $ark_select;
}

// Check for running process
function check_process($script) {
  exec('ps -u www-data -f', $output);
  foreach ($output as $line) {
    if (stristr($line, $script)) {
      return true;
    }
  }
  return false;
}

// If no caching process is currently running, create the cached file in the background
// If a process is running, the cache-track.php script will call cache_next() when it's done
function start_cache_process($ark) {
  $current_process = check_process('cache.php');
  if (!$current_process) {
    $cache_process = new AW_Process('php ' . AW_HTML . '/tools/cache.php ' . $ark);
    new AW_Process('php ' . AW_HTML . '/tools/track-process.php cache ' . $cache_process->getPid() . ' ' . $ark);
  }
}

// Cache the next waiting finding aid with a cached value of 0
function cache_next() {
  if ($mysqli = connect()) {
    $ark_result = $mysqli->query('SELECT ark FROM arks WHERE cached=0 AND active=1 AND file<>"" ORDER BY date ASC LIMIT 1');
    if ($ark_result->num_rows == 1) {
      while ($ark_row = $ark_result->fetch_row()) {
        start_cache_process($ark_row[0]);
      }
    }
    $mysqli->close();
  }
}

// Run an index update as a process
function start_index_process() {
  $current_process = check_process('update-indexes.php');
  if (!$current_process) {
    $index_process = new AW_Process('php ' . AW_HTML . '/tools/update-indexes.php');
    new AW_Process('php ' . AW_HTML . '/tools/track-process.php index ' . $index_process->getPid());
  }
}

// Update indexes if any update rows have a complete value of 0
function index_next() {
  if ($mysqli = connect()) {
    $update_result = $mysqli->query('SELECT id FROM updates WHERE complete=0');
    if ($update_result->num_rows > 0) {
      start_index_process();
    }
    $mysqli->close();
  }
}

// Get a response from the ArchivesSpace REST API
function get_as_response($url, $type) {
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, $url);
  curl_setopt($ch, CURLOPT_HTTPHEADER, array('X-ArchivesSpace-Session: ' . $_SESSION['as_session']));
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  $raw_response = curl_exec($ch);
  if ($raw_response === false) {
    $response = curl_error($ch);
  }
  else {
    if ($type == 'json') {
      $response = json_decode($raw_response);
    }
    else {
      $response = $raw_response;
    }
  }
  curl_close($ch);
  return $response;
}

// Get a response from the ArchivesSpace OAI-PMH interface
// Returns SimpleXml object or exception
function get_as_oaipmh($url) {
  $response = null;
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, $url);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
  $raw_response = curl_exec($ch);
  if ($raw_response === false) {
    throw new Exception(curl_error($ch));
  }
  else {
    $response = simplexml_load_string($raw_response);
  }
  curl_close($ch);
  return $response;
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

function toggle_maintenance_mode($on) {
  $file = 'maintenance.html';
  if ($on) {
    $html = file_get_contents(AW_TOOL_INCLUDES . '/' . $file, true);
    $fh = fopen(AW_HTML . '/' . $file, 'w');
    fwrite($fh, $html);
    fclose($fh);
  }
  else {
    unlink(AW_HTML . '/' . $file);
  }
}

?>
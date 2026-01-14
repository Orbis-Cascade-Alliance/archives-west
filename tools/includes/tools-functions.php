<?php
// Include other function files
include('file-functions.php');
include('process-functions.php');

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
function print_errors($errors) {
  ob_start();
  echo '<ul class="errors">';
  foreach ($errors as $error) {
    echo '<li>' . $error . '</li>';
  }
  echo '</ul>';
  $error_list = ob_get_contents();
  ob_end_clean();
  return $error_list;
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
function create_job($job_type, $repo_id, $user_id) {
  $job_id = null;
  if ($mysqli = connect()) {
    $insert_stmt = $mysqli->prepare('INSERT INTO jobs (type, repo_id, user) VALUES(?, ?, ?)');
    $insert_stmt->bind_param('sii', $job_type, $repo_id, $user_id);
    $insert_stmt->execute();
    $insert_stmt->close();
    $job_id = $mysqli->insert_id;
    $mysqli->close();
  }
  return $job_id;
}

// Queue a file for CloudFront invalidation
function queue_invalidation($file) {
  if ($mysqli = connect()) {
    $mysqli->query('INSERT INTO cf (file) VALUES ("' . $file . '")');
    $cf_id = $mysqli->insert_id;
    $mysqli->close();
  }
  return $cf_id;
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

// Turn on maintenance mode for updates
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
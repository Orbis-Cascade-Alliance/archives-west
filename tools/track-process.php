<?php
// Track the status of a finding aid caching process

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');

// Check status of the caching process every 10 seconds
// Returns false after 5 minutes
function check_completion($process, $start) {
  $max_time = 300;
  if (!$process->status()) {
    return true;
  }
  else {
    if ((time() - $start) < $max_time) {
      sleep(1);
      return check_completion($process, $start);
    }
    else {
      return false;
    }
  }
}

// Get type, process ID, and arguments
$types = array('cache', 'index', 'harvest', 'upload', 'harvest-api', 'upload-api');
$type = '';
$pid = 0;
if (isset($argv[1]) && !empty($argv[1]) && in_array($argv[1], $types)) {
  $type = $argv[1];
}
if (isset($argv[2]) && !empty($argv[2])) {
  $pid = filter_var($argv[2], FILTER_SANITIZE_NUMBER_INT);
}
if ($type == 'cache') {
  $ark = '';
  if (isset($argv[3]) && !empty($argv[3])) {
    $ark = filter_var($argv[2], FILTER_SANITIZE_STRING);
  }
}
else if ($type == 'harvest' || $type == 'upload' || $type == 'harvest-api' || $type == 'upload-api') {
  $job_id = 0;
  if (isset($argv[3]) && !empty($argv[3])) {
    $job_id = filter_var($argv[3], FILTER_SANITIZE_NUMBER_INT);
  }
  if ($type == 'harvest-api' || $type == 'upload-api') {
    $as_session = $argv[4];
    $as_expires = $argv[5];
  }
}

if ($type != '' && $pid != 0) {
  // Create process object to check status
  $process = new AW_Process();
  $process->setPID($pid);
  
  // Start tracking
  $start = time();
  $complete = check_completion($process, $start);
  
  // If tracking function returned false, notify webmaster
  if (!$complete) {
    $message = 'Process ' . $pid;
    if ($ark) {
      $message .= ' for ARK ' . $ark;
    }
    else if ($job_id) {
      $message .= ' for job ' . $job_id;
    }
    $message .= ' failed to complete within 5 minutes.';
    $mail = new AW_Mail('webmaster@orbiscascade.org', ucwords($type) . ' Failed!', $message);
    $mail->send();
  }
  else {
    // Start the next process
    switch ($type) {
      case 'cache': cache_next();
      break;
      case 'index': index_next();
      break;
      case 'harvest': harvest_next($job_id);
      break;
      case 'upload': upload_next($job_id);
      break;
      case 'harvest-api': harvest_next_api($job_id, $as_session, $as_expires);
      break;
      case 'upload-api': upload_next_api($job_id, $as_session, $as_expires);
      break;
    }
  }
}
?>


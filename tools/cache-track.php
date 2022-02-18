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

// Get process ID and ark
$pid = 0;
$ark = '';
if (isset($argv[1]) && !empty($argv[1])) {
  $pid = filter_var($argv[1], FILTER_SANITIZE_NUMBER_INT);
}
if (isset($argv[2]) && !empty($argv[2])) {
  $ark = filter_var($argv[2], FILTER_SANITIZE_STRING);
}

if ($pid != 0 && $ark != '') {
  // Create process object to check status
  $process = new AW_Process();
  $process->setPID($pid);
  
  // Start tracking
  $start = time();
  $complete = check_completion($process, $start);
  
  // If tracking function returned false, notify webmaster
  if (!$complete) {
    $mail = new AW_Mail('webmaster@orbiscascade.org', 'Cache Failed!', 'Process ' . $pid . ' for ARK ' . $ark . ' failed to complete within 5 minutes.');
    $mail->send();
  }
  // If process is complete, start the cache process for another waiting finding aid
  else {
    cache_next();
  }
}
?>


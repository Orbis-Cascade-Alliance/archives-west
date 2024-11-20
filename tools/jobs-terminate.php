<?php
// Terminate a job by marking the complete column 2 (Failed)

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

// Get user from session
$user = get_session_user();

if ($user->is_admin()) {
  if (isset($_POST['job_id']) && !empty($_POST['job_id'])) {
    $job_id = filter_var($_POST['job_id'], FILTER_SANITIZE_NUMBER_INT);
    try {
      $job = new AW_Job($job_id);
      $job->set_failed();
      echo '<p>Job #' . $job_id . ' marked Failed.</p>';
    }
    catch (Exception $e) {
      echo '<p>Error: ' . $e->getMessage() . '</p>';
    }
  }
  else {
    echo '<p>Job ID is required.</p>';
  }
}
else {
  echo '<p>This tool is for admins only.</p>';
}
?>

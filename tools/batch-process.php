<?php
require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}
$batch_errors = array();

// Get user from session
$user = get_session_user();

// Get repository
$repo_id = get_user_repo_id($user);

// Get files
if (isset($_FILES['file']) && !empty($_FILES['file'])) {
  
  // Create job and process files
  if ($job_id = create_job('batch', $repo_id)) {
    try {
      $job = new AW_Job($job_id);
      $job->process_files($_FILES['file']);
    }
    catch (Exception $e) {
      $batch_errors[] = $e->getMessage();
    }
  
    // Print report
    echo '<h2>Results</h2>';
    if (empty($batch_errors)) {
      echo $job->get_report();
    }
    else {
      echo '<ul class="errors">';
      foreach ($batch_errors as $error) {
        echo '<li>' . $error . '</li>';
      }
      echo '</ul>';
    }
  }
}
?>
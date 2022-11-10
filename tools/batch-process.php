<?php
require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}
$batch_errors = array();
$job = null;

// Get user from session
$user = get_session_user();

// Get repository
$repo_id = get_user_repo_id($user);

// Get files
if (isset($_FILES['file']) && !empty($_FILES['file'])) {
  
  // Create array of names and contents
  $files = array();
  for ($f=0; $f < count($_FILES['file']['name']); $f++) {
    $file_name = $_FILES['file']['name'][$f];
    $file_contents = file_get_contents($_FILES['file']['tmp_name'][$f]);
    $files[$file_name] = $file_contents;
  }
  
  // Get replace option
  $replace = 0;
  if (isset($_POST['replace_files']) && $_POST['replace_files'] == '1') {
    $replace = 1;
  }
  
  // Create job and process files
  if ($job_id = create_job('batch', $repo_id, $user->get_id())) {
    try {
      $job = new AW_Job($job_id);
      if ($replace == 1) {
        $job->set_replace(1);
      }
      $job->process_files($files);
      $job->set_complete();
      // Optimize index
      index_next();
    }
    catch (Exception $e) {
      $batch_errors[] = $e->getMessage();
    }
  }
  else {
    $batch_errors[] = 'Error creating batch job';
  }
  
  // Print report
  echo '<h2>Results</h2>';
  if ($job && empty($batch_errors)) {
    echo $job->get_report();
  }
  else {
    echo print_errors($batch_errors);
  }
}
?>
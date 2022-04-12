<?php
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();
$harvest_errors = array();
$job_id = 0;

// Get user from session
$user = get_session_user();

// Get repository
$repo_id = get_user_repo_id($user);
try {
  $repo = new AW_Repo($repo_id);
  $as_host = $repo->get_as_host_api();
}
catch (Exception $e) {
  $harvest_errors[] = $e->getMessage();
}

// Get ArchivesSpace repository
$as_repo_id = null;
if (isset($_POST['as_repo_id']) && !empty($_POST['as_repo_id'])) {
  $as_repo_id = filter_var($_POST['as_repo_id'], FILTER_SANITIZE_NUMBER_INT);
}
else {
  $harvest_errors[] = 'ArchivesSpace repository is required.';
}

// Check authentication to ArchivesSpace
if (!isset($_SESSION['as_session']) || (isset($_SESSION['as_expires']) && time() > isset($_SESSION['as_expires']))) {
  $harvest_errors[] = 'ArchivesSpace authentication expired.';
}

// Create job and start harvest process
if (empty($harvest_errors)) {
  if ($job_id = create_job('as', $repo_id, $user->get_id())) {
    try {
      $job = new AW_Job($job_id);
      if ($as_repo_id != null) {
        $job->add_set($as_repo_id);
      }
      new AW_Process('php ' . AW_HTML . '/tools/archivesspace/start-harvest.php ' . $job_id . ' ' . $_SESSION['as_session'] . ' ' . $_SESSION['as_expires']);
      echo '<p>Harvest job #' . $job_id . ' has been created. <a href="' . AW_DOMAIN . '/tools/jobs-view.php?j=' . $job_id . '">View progress</a>.</p>';
    }
    catch (Exception $e) {
      $harvest_errors[] = $e->getMessage();
    }
  }
  else {
    $harvest_errors[] = 'Error creating harvest job';
  }
}

// Print errors
if (!empty($harvest_errors)) {
  echo print_errors($harvest_errors);
}
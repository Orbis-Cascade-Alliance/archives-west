<?php
// Start a new ArchivesSpace harvest by getting all identifiers

require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_INCLUDES . '/classes/harvest.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();
$job_id = 0;
$harvest_errors = array();

// Get user from session
$user = get_session_user();

// Get repository
$repo_id = get_user_repo_id($user);
try {
  $repo = new AW_Repo($repo_id);
  $as_host = $repo->get_as_host();
}
catch (Exception $e) {
  $harvest_errors[] = $e->getMessage();
}

// Get ArchivesSpace set
$as_set = null;
if (isset($_POST['as_set']) && !empty($_POST['as_set'])) {
  $as_set = filter_var($_POST['as_set'], FILTER_SANITIZE_NUMBER_INT);
}

// Get start date
$start_date = null;
if (isset($_POST['start_date']) && !empty($_POST['start_date'])) {
  $start_date = filter_var($_POST['start_date'], FILTER_SANITIZE_STRING);
}

// Get replace checkbox
$replace = 0;
if (isset($_POST['replace_file']) && $_POST['replace_file'] == 1) {
  $replace = 1;
}

// Create job and start harvest process
if (empty($harvest_errors)) {
  if ($job_id = create_job('as', $repo_id, $user->get_id())) {
    try {
      $job = new AW_Job($job_id);
      if ($as_set != null) {
        $job->add_set($as_set);
      }
      if ($start_date != null) {
        $job->add_start($start_date);
      }
      if ($replace == 1) {
        $job->set_replace(1);
      }
      new AW_Process('php ' . AW_HTML . '/tools/oai-pmh/start-harvest.php ' . $job_id);
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


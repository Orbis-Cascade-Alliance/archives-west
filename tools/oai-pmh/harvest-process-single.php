<?php
// Start a new ArchivesSpace harvest for one given identifier

require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_INCLUDES . '/classes/harvest.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();
$job_id = 0;
$job = null;
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

// Get ArchivesSpace resource identifier
$resource_id = null;
if (isset($_POST['as_resource']) && !empty($_POST['as_resource'])) {
  $as_resource = filter_var($_POST['as_resource'], FILTER_SANITIZE_STRING);
  if (substr($as_resource, 0, 1) == '/') {
    $resource_id = $as_resource;
  }
  else {
    $prefix = $repo->get_oaipmh_prefix();
    $path = parse_url($as_resource, PHP_URL_PATH);
    $resource_id = $prefix . '/' . $path;
  }
}
else {
  $harvest_errors[] = 'Link is required.';
}

// Get replace checkbox
$replace = 0;
if (isset($_POST['replace_file']) && $_POST['replace_file'] == 1) {
  $replace = 1;
}

// Create job and harvest EAD
if (empty($harvest_errors)) {
  if ($resource_id != null) {
    if ($job_id = create_job('as', $repo_id, $user->get_id())) {
      try {
        $job = new AW_Job($job_id);
        if ($replace == 1) {
          $job->set_replace(1);
        }
        $harvest = new AW_Harvest($as_host);
        $harvest->add_id($resource_id);
        $harvest->harvest_eads($job_id);
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
  else {
    $harvest_errors[] = 'Error determining resource ID.';
  }
}

// If errors, terminate job and print to report
if (!empty($harvest_errors)) {
  $report = print_errors($harvest_errors);
  if ($job) {
    $job->set_complete();
    $fh = fopen($job->get_report_path(), 'a');
    fwrite($fh, $report);
    fclose($fh);
  }
  echo $report;
}


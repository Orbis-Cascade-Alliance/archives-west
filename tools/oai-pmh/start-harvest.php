<?php
// Start a new ArchivesSpace harvest by getting all identifiers

require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_INCLUDES . '/classes/harvest.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');

$job_id = 0;
$job = null;
$harvest_errors = array();

if (isset($argv[1]) && !empty($argv[1])) {
  $job_id = $argv[1];
  try {
    $job = new AW_Job($job_id);
    $as_set = $job->get_set();
    $start_date = $job->get_start();
    $repo = new AW_Repo($job->get_repo_id());
    $as_host = $repo->get_as_host_oaipmh();
    // Get identifiers
    try {
      $harvest = new AW_Harvest($as_host, $as_set, $start_date);
      $harvest->harvest_ids();
      if (!empty($harvest->get_ids())) {
        $harvest->harvest_eads($job_id);
      }
    }
    catch (Exception $e) {
      $harvest_errors[] = $e->getMessage();
    }
  }
  catch (Exception $e) {
    $harvest_errors[] = $e->getMessage();
  } 
}
// If errors, terminate job and print to report
if ($job && !empty($harvest_errors)) {
  $job->set_complete();
  $report = print_errors($harvest_errors);
  $fh = fopen($job->get_report_path(), 'a');
  fwrite($fh, $report);
  fclose($fh);
}

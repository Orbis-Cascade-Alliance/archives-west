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
  $as_session = $argv[2];
  $as_expires = $argv[3];
  // Check authentication to ArchivesSpace
  if (time() > $as_expires) {
    $harvest_errors[] = 'ArchivesSpace authentication expired.';
  }
  else {
    try {
      $job = new AW_Job($job_id);
      $as_repo_id = $job->get_set();
      $repo = new AW_Repo($job->get_repo_id());
      $as_host = $repo->get_as_host_api();
      // Get identifiers
      $list_response = get_as_response($as_host . '/repositories/' . $as_repo_id . '/resources?all_ids=true', 'json', $as_session);
      if (is_array($list_response)) {
        if (!empty($list_response)) {
          if ($mysqli = connect()) {
            $insert_stmt = $mysqli->prepare('INSERT INTO harvests (job_id, resource_id) VALUES (?, ?)');
            $insert_stmt->bind_param('ii', $job_id, $resource_id);
            foreach ($list_response as $resource_id) {
              $insert_stmt->execute();
            }
            $insert_stmt->close();
            $mysqli->close();
            // Start harvest process
            harvest_next_api($job_id, $as_session, $as_expires);
          }
          else {
            $harvest_errors[] = 'Error writing ArchivesSpace resource identifiers to database.';
          }
        }
        else {
          $harvest_errors[] = 'ArchivesSpace returned an empty resource list.';
        }
      }
      else {
        $harvest_errors[] = 'Error fetching identifiers from ArchivesSpace';
      }
    }
    catch (Exception $e) {
      $harvest_errors[] = $e->getMessage();
    } 
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

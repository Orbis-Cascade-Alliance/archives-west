<?php
// Harvest one EAD record from ArchivesSpace
// This script is called in the background using the AW_Process class

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');

$harvest_id = 0;
$job_id = 0;
$job = null;
$resource_id = 0;
$repo_id = 0;
$ead_errors = array();
if (isset($argv[1]) && !empty($argv[1])) {
  $harvest_id = filter_var($argv[1], FILTER_SANITIZE_NUMBER_INT);
  $as_session = $argv[2];
  $as_expires = $argv[3];
  if (time() > $as_expires) {
    $harvest_errors[] = 'ArchivesSpace authentication expired.';
  }
  else {
    if ($mysqli = connect()) {
      $repo_result = $mysqli->query('SELECT harvests.job_id, harvests.resource_id, jobs.repo_id, jobs.as_set FROM harvests LEFT JOIN jobs ON harvests.job_id=jobs.id WHERE harvests.id=' . $harvest_id);
      if ($repo_result->num_rows == 1) {
        while ($repo_row = $repo_result->fetch_assoc()) {
          $job_id = $repo_row['job_id'];
          $resource_id = $repo_row['resource_id'];
          $repo_id = $repo_row['repo_id'];
          $as_repo_id = $repo_row['as_set'];
        }
      }
      $mysqli->close();
    }
    if ($job_id && $resource_id && $repo_id) {
      
      // Get EAD from ArchivesSpace
      $repo = new AW_Repo($repo_id);
      $as_host = $repo->get_as_host_api();
      $xml_string = get_as_response($as_host . '/repositories/' . $as_repo_id . '/resource_descriptions/' . $resource_id . '.xml?include_unpublished=false&include_daos=true&numbered_cs=true&print_pdf=false&ead3=false', 'xml', $as_session);
      if ($ead = simplexml_load_string($xml_string)) {
        if ($ead_filename = (string) $ead->eadheader->eadid) {
          $ead_filename = strtolower($ead_filename);
          // Save to file
          $temp_dir = AW_REPOS . '/' . $repo->get_folder() . '/temp';
          if (!is_dir($temp_dir)) {
            mkdir($temp_dir, 0755);
          }
          $temp_file = $temp_dir . '/' . $harvest_id . '.xml';
          $fh = fopen($temp_file, 'w');
          fwrite($fh, $ead->asXML());
          fclose($fh);
        }
        else {
          $ead_errors[] = 'No filename found in eadheader/eadid for resource ' . $resource_id;
        }
      }
      else {
        $ead_errors[] = 'Error loading XML for resource ' . $resource_id;
      }
      
      // Check file and update MySQL
      if (file_exists($temp_file)) {
        $downloaded = 1;
      }
      else {
        $downloaded = 2;
        $ead_errors[] = 'Error saving file for '. $resource_id;
      }
      if ($mysqli = connect()) {
        $download_stmt = $mysqli->prepare('UPDATE harvests SET downloaded=? WHERE id=?');
        $download_stmt->bind_param('ii', $downloaded, $harvest_id);
        $download_stmt->execute();
        $download_stmt->close();
        $mysqli->close();
      }
    }
    else {
      $ead_errors[] = 'Could not get information for harvest #' . $harvest_id;
    }
  }
}
// Print errors to job report
if ($job && !empty($ead_errors)) {
  $report = print_errors($ead_errors);
  $fh = fopen($job->get_report_path(), 'a');
  fwrite($fh, $report);
  fclose($fh);
}

?>
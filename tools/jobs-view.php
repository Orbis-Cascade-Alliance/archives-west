<?php
// View the report of a batch job

// Include definitions
$page_title = 'Job Viewer';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/tools/layout/batch.css" />
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/tools/layout/compliance.css" />
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/tools/layout/jobs-view.css" />
<script src="<?php echo AW_DOMAIN; ?>/tools/scripts/batch.js"></script>
<script src="<?php echo AW_DOMAIN; ?>/tools/scripts/compliance.js"></script>
<script src="<?php echo AW_DOMAIN; ?>/tools/scripts/jobs-view.js"></script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

// Get job ID
$job_id = 0;
if (isset($_GET['j']) && !empty($_GET['j'])) {
  $job_id = filter_var($_GET['j'], FILTER_SANITIZE_NUMBER_INT);
}

function print_as_details($job) {
  $set = $job->get_set() == '' ? 'All Sets' : $job->get_set();
  $to_return = '<p>Set: ' . $set . '</p>';
  if ($job->get_start()) {
    $to_return .= '<p>Date From: '. $job->get_start() . '</p>';
  }
  return $to_return;
}

if ($job_id != 0) {
  try {
    $job = new AW_Job($job_id);
    if ($job->get_complete()) {
      if ($report = $job->get_report()) {
        $job_types = get_job_types();
        echo '<div id="report">';
        echo '<h2>Report for Job #' . $job_id . ' on ' . date('F j, Y', strtotime($job->get_date())) . '</h2>';
        echo '<p>Type: ' . $job_types[$job->get_type()] . '</p>'; 
        if ($job->get_type() == 'as') {
          echo print_as_details($job);
        }
        echo $report;
        echo '</div>';
      }
    }
    else {
      if ($job->get_type() == 'as') {
        echo '<h2>Progress Report for Job #' . $job_id . '</h2>';
        echo print_as_details($job);
        echo '<div id="progress">Checking progress...</div>';
      }
      else {
        echo '<p>This job is in progress.</p>'; 
      }
    }
  }
  catch (Exception $e) {
    echo '<p class="errors">' . $e->getMessage() . '</p>';
  }
}
else {
  echo '<p>Job ID is required.</p>';
}

?>
<div id="dialog-appnote" class="dialog" title="Comments/Application Notes"></div>
<div id="dialog-source" class="dialog" title="Source"></div>
<?php
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
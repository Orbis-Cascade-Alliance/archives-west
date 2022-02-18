<?php
// View the report of a batch job

// Include definitions
$page_title = 'Job Viewer';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
<link rel="stylesheet" href="/tools/layout/batch.css" />
<link rel="stylesheet" href="/tools/layout/compliance.css" />
<script src="/tools/scripts/batch.js"></script>
<script src="/tools/scripts/compliance.js"></script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

// Get job ID
$job_id = 0;
if (isset($_GET['j']) && !empty($_GET['j'])) {
  $job_id = filter_var($_GET['j'], FILTER_SANITIZE_NUMBER_INT);
}

if ($job_id != 0) {
  try {
    $job = new AW_Job($job_id);
    if ($report = $job->get_report()) {
      $job_types = get_job_types();
      echo '<div id="report">';
      echo '<h2>Report for Job #' . $job_id . ' on ' . date('F j, Y', strtotime($job->get_date())) . '</h2>';
      echo '<p>Type: ' . $job_types[$job->get_type()] . '</p>'; 
      echo $report;
      echo '</div>';
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
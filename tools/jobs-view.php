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

if ($job_id != 0) {
  try {
    $job = new AW_Job($job_id);
    if ($job->get_complete()) {
      switch ($job->get_type()) {
        case 'as':
          echo '<a href="' . AW_DOMAIN . '/tools/oai-pmh/harvest.php">Harvest New AS Resource</a>';
        break;
        case 'batch':
          echo '<a href="' . AW_DOMAIN . '/tools/batch.php">Submit New Batch Upload</a>';
        break;
      }
      if ($report = $job->get_report()) {
        $job_types = get_job_types();
        echo '<div id="report">';
        echo '<h2>Report for Job #' . $job_id . ' on ' . date('F j, Y', strtotime($job->get_date())) . '</h2>';
        echo '<p>Type: ' . $job_types[$job->get_type()] . '</p>'; 
        echo $report;
        echo '</div>';
        // Print troubleshooting link for AS Harvests with errors
        if ($job->get_type() == 'as') {
          if (stristr($report, '<ul class="errors">')) {
            echo '<p>For more information, see the <strong>Troubleshooting Errors</strong> section at the end of the <a href="https://drive.google.com/file/d/11D1gfxbGhv7h6LbxHzUrcxnEsgw93e9-/view?usp=sharing" target="_blank">Harvest Documentation</a>.</p>';
          }
        }
      }
    }
    else {
      if ($job->get_type() == 'as') {
        echo '<h2>Progress Report for Job #' . $job_id . '</h2>';
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
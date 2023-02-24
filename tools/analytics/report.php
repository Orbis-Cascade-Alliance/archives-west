<?php
// Include definitions
$page_title = 'Analytics Report';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/tools/layout/report.css" />
<script src="<?php echo AW_DOMAIN; ?>/tools/scripts/report.js"></script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

if ($user->is_admin()) {
  // Print repo select form
  include('../repo-form.php'); 
}
if ($repo_id != 0) {
  
  // Set date range
  $start_date = date('Y-m-d', strtotime('first day of this month'));
  $end_date = date('Y-m-d', time());
  if (isset($_SESSION['report_start']) && !empty($_SESSION['report_start'])) {
    $start_date = $_SESSION['report_start'];
  }
  if (isset($_SESSION['report_end']) && !empty($_SESSION['report_end'])) {
    $end_date = $_SESSION['report_end'];
  }
  
  // Set maximum date
  $max_date = date('F j, Y', strtotime('-3 days'));
  if ($mysqli = connect()) {
    $max_date_result = $mysqli->query('SELECT max(date) FROM views');
    if ($max_date_result->num_rows == 1) {
      while ($row = $max_date_result->fetch_row()) {
        $max_date = date('F j, Y', strtotime($row[0]));
      }
    }
  }
?>
<p>Select a date range below to generate a report of finding aid views from Google Analytics.</p>
<p>Usage was recorded starting August 15, 2016, and data is current up to <strong><?php echo $max_date;?></strong>. For institutions that participated in the digital objects harvesting pilot, analytics include clicks on digital objects through February 2022.</p>
<form id="form-report" method="post" action="report.php">
  <p>
    <label for="start">Start</label> <input type="text" name="start" id="start" class="date" value="<?php echo $start_date; ?>" />
    <label for="end">End</label> <input type="text" name="end" id="end" class="date" value="<?php echo $end_date; ?>"  />
    <input type="submit" value="Get Report" />
  </p>
</form>
<div id="report"></div>
<div id="dialog-dates" title="Dates required">
  <p>Start and end date are required.</p>
</div>
<?php
}

include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
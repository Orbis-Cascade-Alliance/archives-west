<?php
// Cache all transformed XSLT
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');
if ($mysqli = connect()) {
  $job_result = $mysqli->query('SELECT id FROM jobs WHERE complete=0 LIMIT 1');
  if ($job_result->num_rows == 1) {
    while ($job_row = $job_result->fetch_row()) {
      harvest_next($job_row[0]);
    }
  }
  $mysqli->close();
}
?>
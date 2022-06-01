<?php
// Clear older BaseX data logs
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

$last_month = strtotime('-2 months');
exec('rm /opt/basex/data/.logs/' . date('Y-m', $last_month) . '*.log');
?>
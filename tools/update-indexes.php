<?php
// Index text for finding aids that have been added, replaced, or deleted
// This script is called by a cron job

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');

// Perform updates
try {
  $updates = new AW_Updates();
  $updates->update_indexes();
}
catch (Exception $e) {
  log_error($e->getMessage());
}
?>


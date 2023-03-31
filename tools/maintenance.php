<?php
// Toggle maintenance mode
require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}
// Get user from session and limit to admins only
$user = get_session_user(true);
if (check_maintenance_mode()) {
  toggle_maintenance_mode(false);
}
else {
  toggle_maintenance_mode(true);
}
header('Location: ' . AW_DOMAIN . '/tools');
?>
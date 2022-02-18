<?php
// Include definitions
$page_title = 'Logout';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
unset($_SESSION['user']);
include(AW_TOOL_INCLUDES . '/tools-header-end.php');
?>

<p>You have logged out of <?php echo TOOLS_TITLE;?>. <a href="login.php">Log back in?</a>

<?php
include(AW_TOOL_INCLUDES . '/tools-footer.php');
session_destroy();
?>
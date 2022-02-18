<?php
// Reset a user's password

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

// Get user from session
$user = get_session_user(true);

$username = '';
$hash = '';
if (isset($_POST['username']) && !empty($_POST['username'])) {
  $username = filter_var($_POST['username'], FILTER_SANITIZE_STRING);
}
if (isset($_POST['new_password']) && !empty($_POST['new_password'])) {
  $hash = password_hash($_POST['new_password'], PASSWORD_DEFAULT);
}
if ($username && $hash) {
  if ($mysqli = connect()) {
    $update_stmt = $mysqli->prepare('UPDATE users SET hash=? WHERE username=?');
    $update_stmt->bind_param('ss', $hash, $username);
    $update_stmt->execute();
    $update_stmt->close();
    $mysqli->close();
  }
}
else {
  die('Username and password are required.');
}
?>
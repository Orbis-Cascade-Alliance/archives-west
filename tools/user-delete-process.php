<?php
// Delete a user

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

// Get user from session
$user = get_session_user(true);

if (isset($_POST['username']) && !empty($_POST['username'])) {
  $username = filter_var($_POST['username'], FILTER_SANITIZE_STRING);
  if ($username != $user->get_username()) {
    if ($mysqli = connect()) {
      $delete_stmt = $mysqli->prepare('DELETE FROM users WHERE username=?');
      $delete_stmt->bind_param('s', $username);
      $delete_stmt->execute();
      $mysqli->close();
    }
  }
  else {
    die('Admins cannot delete their own user accounts.');
  }
}
?>
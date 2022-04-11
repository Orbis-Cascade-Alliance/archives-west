<?php
// Validate an uploaded file

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();

// Get user from session
$user = get_session_user();
$repo_id = 0;
if ($user->is_admin()) {
  $repo_id = $_SESSION['repo_id'];
}
else {
  $repo_id = $user->get_repo_id();
}
 
if (isset($_FILES['ead']) && !empty($_FILES['ead'])) {
  $file_contents = file_get_contents($_FILES['ead']['tmp_name']);
  $validation_result = validate_file($file_contents, $repo_id);
  $_SESSION['validation_file'] = basename($_FILES['ead']['name']);
  $_SESSION['validation_ark'] = $validation_result['ark'];
  $_SESSION['validation_errors'] = $validation_result['errors'];
  
}
header('Location: ' . AW_DOMAIN . '/tools/validation.php');
?>
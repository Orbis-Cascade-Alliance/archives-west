<?php
// Convert an ArchivesSpace EAD for use in Archives West

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}
$converted_ead = '';
$errors = array();

// Get user from session
$user = get_session_user();

// Get repo data
$repo_id = get_user_repo_id($user);
try {
  $repo = new AW_Repo($repo_id);
  if (isset($_FILES['ead']['tmp_name']) && !empty($_FILES['ead']['tmp_name'])) {
    $file_contents = file_get_contents($_FILES['ead']['tmp_name']);
    if (trim($file_contents) != '') {
      $conversion_result = convert_file($file_contents, $repo->get_mainagencycode());
      $converted_ead = $conversion_result['ead'];
      $errors = $conversion_result['errors'];
    }
    else {
      $errors[] = 'File is empty.';
   }
  }
  else {
    $errors[] = 'File is required.';
  }
}
catch (Exception $e) {
  $errors[] = $e->getMessage();
}
$_SESSION['conversion_errors'] = $errors;
$_SESSION['converted_ead'] = $converted_ead;
header('Location: '. AW_DOMAIN . '/tools/as2aw.php');
?>
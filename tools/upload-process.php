<?php
// Process an uploaded file

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();

// Get user from session
$user = get_session_user();

// Get ARK
$ark = '';
if (isset($_POST['ark']) && !empty($_POST['ark'])) {
  $ark = filter_var($_POST['ark'], FILTER_SANITIZE_STRING);
}

// Replace boolean
$replace = 0;
if (isset($_POST['replace']) && $_POST['replace'] == 1) {
  $replace = 1;
}
 
// Upload file 
if (isset($_FILES['ead']) && !empty($_FILES['ead'])) {
  if (isset($_FILES['ead']['tmp_name']) && !empty($_FILES['ead']['tmp_name'])) {
    $file_contents = file_get_contents($_FILES['ead']['tmp_name']);
    $file_name = basename($_FILES['ead']['name']);
    $upload_result = upload_file($file_contents, $file_name, $ark, $replace, $user->get_id());
    $_SESSION['upload_file'] = $file_name;
    $_SESSION['upload_errors'] = $upload_result['errors'];
    start_index_process();
  }
  else {
    $_SESSION['upload_file'] = 'Unknown';
    $_SESSION['upload_errors'] = array('Could not parse XML. File may be empty or too large.');
  }
}
header('Location: ' . AW_DOMAIN . '/tools/upload.php?ark=' . $ark);
?>
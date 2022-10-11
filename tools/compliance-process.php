<?php
// Produce a report of compliance with Best Practice Guidelines

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();

// Get user from session
$user = get_session_user();

// Get type of report from POST
$all = 'yes';
if (isset($_POST['all']) && $_POST['all']=='no') {
  $all = 'no';
}

// Get uploaded file from POST
$transformed_ead = null;
if (isset($_FILES['ead']) && !empty($_FILES['ead'])) {
  $file_contents = file_get_contents($_FILES['ead']['tmp_name']);
  $compliance_results = check_compliance($file_contents, $all);
  $_SESSION['compliance_report'] = $compliance_results['report'];
  $_SESSION['compliance_errors'] = $compliance_results['errors'];
}
header('Location: ' . AW_DOMAIN . '/tools/compliance.php');
?>
<?php
// Produce a report of compliance with Best Practice Guidelines

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

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
  
  $errors = array();
  
  // Load and validate XML
  $file_contents = file_get_contents($_FILES['ead']['tmp_name']);
  $file_contents = strip_namespaces($file_contents);
  if (trim($file_contents) != '') {
    libxml_use_internal_errors(true);
    $doc = new DOMDocument;
    $doc->loadXML($file_contents);
    $errors = add_errors($errors, libxml_get_errors());
    if (!$errors) {
      // Get XSL
      $xsl = new DOMDocument;
      $xsl->load(AW_TOOLS . '/xsl/bpg.xsl');

      // Process
      $proc = new XSLTProcessor();
      $proc->importStyleSheet($xsl);
      $proc->setParameter('axsl', 'all', $all);
      $transformed_xml = $proc->transformToXml($doc);
      $errors = add_errors($errors, libxml_get_errors());
    }
  }
  else {
    $errors[] = 'File is empty.';
  }
  
  $_SESSION['compliance_report'] = $transformed_xml;
  $_SESSION['compliance_errors'] = $errors;
}
if (!isset($type) || $type != 'batch') {
  header('Location: ' . AW_DOMAIN . '/tools/compliance.php');
}
?>
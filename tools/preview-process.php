<?php
// Process an uploaded file

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}
$errors = array();
$stripped_transformed = '';

// Get user from session
$user = get_session_user();
$repo_id = get_user_repo_id($user);
try { 
  $repo = new AW_Repo($repo_id);
}
catch (Exception $e) {
  $errors[] = $e->getMessage();
}

if (empty($errors)) {
  if (isset($_FILES['ead']) && !empty($_FILES['ead'])) {
    if (isset($_FILES['ead']['tmp_name']) && !empty($_FILES['ead']['tmp_name'])) {
      // Strip namespaces
      $xml_string = file_get_contents($_FILES['ead']['tmp_name']);
      $new_string = strip_namespaces($xml_string);
      
      // String to XML object
      $xml = simplexml_load_string($new_string);

      // Add contact and license info from repos table
      $additions_xml = $xml->addChild('aw-additions');
      $additions_xml->addChild('rights', $repo->get_rights());
      $repo_xml = $additions_xml->addChild('repository');
      $repo_xml->addchild('name', $repo->get_name());
      $repo_xml->addChild('url', $repo->get_url());
      $address_xml = $repo_xml->addChild('address');
      $l = 1;
      if ($repo->get_address()) {
        foreach ($repo->get_address() as $line) {
          $address_xml->addChild('line' . $l, $line);
          $l++;
        }
      }
      $repo_xml->addChild('phone', $repo->get_phone());
      $repo_xml->addChild('fax', $repo->get_fax());
      $repo_xml->addChild('email', $repo->get_email());

      // Get XSL
      $xsl = new DOMDocument;
      $xsl->load(AW_HTML . '/xsl/nwda_0.1.xsl');

      // Process
      libxml_use_internal_errors(true);
      $proc = new XSLTProcessor();
      $proc->importStyleSheet($xsl);
      $transformed = $proc->transformToXML($xml);
      if (!$transformed) {
        foreach (libxml_get_errors() as $error) {
          $errors[] = $error->message;
        }
      }
      else {
        $stripped_transformed = preg_replace('/<!DOCTYPE[^>]+>[\n\r]/', '', $transformed);
      }
    }
    else {
      $errors[] = 'Could not parse file. Check for syntax errors.';
    }
  }
  else {
    $errors[] = 'File is empty.';
  }
}
if (!$stripped_transformed) {
  $errors[] = 'Result of transformation is empty. Try the <a href="/tools/validation.php">Document Validation</a> tool to see errors in the XML.';
}
if (!empty($errors)) {
  echo print_errors($errors);
}
else {
  include(AW_INCLUDES . '/header.php');
?>
  <title>Preview - <?php echo SITE_TITLE; ?></title>
  <link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/layout/finding-aid.css" />
  <link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/layout/finding-aid-print.css" />
  <script src="<?php echo AW_DOMAIN; ?>/scripts/jquery.mark.min.js"></script>
  <script src="<?php echo AW_DOMAIN; ?>/scripts/finding-aid.js"></script>
<?php
  include(AW_INCLUDES . '/header-end.php');
?>
<div id="downloads">
  <a class="btn" href="javascript:void(0)" onclick="print_finding_aid()">Print</a>
</div>
<?php
  echo $stripped_transformed;
  include(AW_INCLUDES . '/footer.php');
}
?>
<?php
// Convert ArchivesSpace finding aids to Archives West EAD2

// Include definitions
$page_title = 'Compliance Checker';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
  <link rel="stylesheet" href="/tools/layout/compliance.css" />
  <script src="/tools/scripts/compliance.js"></script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');
?>

<p>This tool produces a report of compliance with Archives West Best Practice Guidelines (BPG).</p>

<form id="form-convert" method="post" action="<?php echo AW_DOMAIN; ?>/tools/compliance-process.php" enctype="multipart/form-data">
  <p><input type="file" name="ead" id="ead" /></p>
  <ul style="list-style:none;">
    <li><input type="radio" name="all" value="no" id="all_no" checked="checked" /> <label for="all_no">Required/Mandatory BPG Only</label>
    <li><input type="radio" name="all" value="yes" id="all_yes" /> <label for="all_yes">All BPG</label></li>
  </ul>
  <p><input type="submit" value="Check Compliance" /></p>
</form>

<?php
// Print error and confirmation messages
if (isset($_SESSION['compliance_report']) && !empty($_SESSION['compliance_report'])) {
  if (isset($_SESSION['compliance_errors']) && !empty($_SESSION['compliance_errors'])) {
    echo print_errors($_SESSION['compliance_errors']);
  }
  echo '<frame>' . $_SESSION['compliance_report'] . '</frame>';
  $_SESSION['compliance_report'] = '';
  $_SESSION['compliance_errors'] = array();
}
?>
<div id="dialog-appnote" class="dialog" title="Comments/Application Notes"></div>
<div id="dialog-source" class="dialog" title="Source"></div>
<?php
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
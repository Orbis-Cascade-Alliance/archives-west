<?php
// Convert ArchivesSpace finding aids to Archives West EAD2

// Include definitions
$page_title = 'ArchivesSpace EAD Converter';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
  <link rel="stylesheet" href="/tools/layout/as2aw.css" />
  <script src="/tools/scripts/as2aw.js"></script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');
?>

<p>This tool transforms EAD files exported by ArchivesSpace to bring them in line with the encoding requirements and best practices guidelines for Archives West.</p>

<p>Maximum file size is <strong><?php echo MAX_FILE_SIZE;?></strong>. If your exported EAD file is larger, submit a <a href="https://www.orbiscascade.org/programs/ulc/help-request/">ULC Help Request</a> for staff to process the file manually.</p>

<?php
if ($user->is_admin()) { 
  // Print repo select form
  include('repo-form.php');
}
if ($repo_id != 0) {?>

  <form id="form-convert" method="post" action="<?php echo AW_DOMAIN; ?>/tools/as2aw-process.php" enctype="multipart/form-data">
    <p><input type="file" name="ead" id="ead" /></p>
    <p><input type="submit" value="Convert EAD" /></p>
  </form>

  <?php
  if (isset($_SESSION['converted_ead']) && $_SESSION['converted_ead'] !== null) {
    if (isset($_SESSION['conversion_errors']) && !empty($_SESSION['conversion_errors'])) {
      echo print_errors($_SESSION['conversion_errors']);
    }
    else {
  ?>
    <form id="form-download" method="post" action="as2aw.php">
    <textarea id="converted-ead"><?php echo str_replace('&amp;', '&amp;amp;', $_SESSION['converted_ead']); ?></textarea>
    <p><input type="button" onclick="download_ead()" value="Download File" /></p>
    </form>
  <?php
    }
    $_SESSION['converted_ead'] = null;
    $_SESSION['conversion_errors'] = array();
  }
}

include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
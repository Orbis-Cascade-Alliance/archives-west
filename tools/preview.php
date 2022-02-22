<?php
// Print upload file page

// Include definitions
$page_title = 'Document Preview';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

?>
<p>This tool previews the transformation of an EAD for Archives West. Maximum file size is <strong><?php echo MAX_FILE_SIZE;?></strong>.</p>
<?php
if ($user->is_admin()) { 
  // Print repo select form
  include('repo-form.php');
}
if ($repo_id != 0) {
  if (isset($_SESSION['preview_html']) && !empty($_SESSION['preview_html'])) {
    if (isset($_SESSION['preview_errors']) && !empty($_SESSION['preview_errors'])) {
      echo print_errors('preview_errors');
    }
    else {
      echo '<div id="preview">' . $_SESSION['preview_html'] . '</div>';
    }
    $_SESSION['preview_errors'] = array();
  }
?>
  <form id="form-preview" action="<?php echo AW_DOMAIN; ?>/tools/preview-process.php" method="post" enctype="multipart/form-data" target="_blank">
    <p><input type="file" name="ead" id="ead"></p>
    <p><input type="submit" value="Preview Finding Aid" name="submit"></p>
  </form>
<?php 
} 
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
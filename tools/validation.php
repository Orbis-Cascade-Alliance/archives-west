<?php
// Print document validation page

// Include definitions
$page_title = 'Document Validation';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
include(AW_TOOL_INCLUDES . '/tools-header-end.php');
?>
<p>This tool validates a file against the EAD DTD and checks for the presence of a valid ARK. Maximum file size is <strong><?php echo MAX_FILE_SIZE;?></strong>.</p>
<?php
if ($user->is_admin()) { 
  // Print repo select form
  include('repo-form.php');
}
if ($repo_id != 0) {
  // Print error and confirmation messages
  if (isset($_SESSION['validation_file']) && !empty($_SESSION['validation_file'])) {
    if (isset($_SESSION['validation_errors']) && !empty($_SESSION['validation_errors'])) {
      echo print_errors($_SESSION['validation_errors']);
    }
    else {
      echo '<p class="success">' . $_SESSION['validation_file'] . ' for ARK ' . $_SESSION['validation_ark'] . ' is valid!</p>';
    }
    $_SESSION['validation_file'] = '';
    $_SESSION['validation_ark'] = '';
    $_SESSION['validation_errors'] = array();
  }
  ?>
  <form action="<?php echo AW_DOMAIN; ?>/tools/validation-process.php" method="post" enctype="multipart/form-data">
    <p><input type="file" name="ead" id="ead"></p>
    <p><input type="submit" value="Validate File" name="submit"></p>
  </form>
<?php 
} 
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
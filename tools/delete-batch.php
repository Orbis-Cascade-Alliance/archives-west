<?php
// Print batch deletion page

// Include definitions
$page_title = 'Batch Deletion';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

// Print confirmation
if (isset($_SESSION['fa_deleted']) && !empty($_SESSION['fa_deleted'])) {
  echo '<div class="success">
    <p>Finding aids deleted:</p>
    <ul><li>' . implode('</li><li>', $_SESSION['fa_deleted']) . '</li></ul>
  </div>';
  $_SESSION['fa_deleted'] = array();
}
?>

<p>Enter ARKs below for deletion, separated by line breaks.</p>
<form id="form-batch-delete" action="<?php echo AW_DOMAIN; ?>/tools/delete-process.php" method="post">
  <input type="hidden" name="type" value="batch" />
  <p><textarea name="ark" rows="10" cols="50"></textarea></p>
  <p><input type="submit" value="Delete Finding Aids" /></p>
</form>

<?php
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
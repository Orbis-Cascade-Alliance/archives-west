<?php
// Delete a repository

// Include definitions
$page_title = 'Delete Repository';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
include(AW_TOOL_INCLUDES . '/tools-header-end.php');
if ($user->is_admin()) {
  // Print repo select form
  include('repo-form.php');
  
  // Print error and confirmation messages
  if (isset($_SESSION['repo_deletion_id'])) {
    if (isset($_SESSION['repo_deletion_errors']) && !empty($_SESSION['repo_deletion_errors'])) {
      echo print_errors($_SESSION['repo_deletion_errors']);
    }
    else if ($_SESSION['repo_deletion_id'] != 0) {
      echo '<p class="success">Repository #' . $_SESSION['repo_deletion_id'] . ' deleted.</p>';
    }
    $_SESSION['repo_deletion_id'] = 0;
    $_SESSION['repo_deletion_errors'] = array();
  }
  
  if ($repo_id != 0) {
    $repo = new AW_Repo($repo_id);
  ?>
  <p>Clicking the button below will:</p>
  <ol>
    <li>Remove all <strong><?php echo $repo->get_name(); ?></strong> finding aids from BaseX.</li>
    <li>Permanently delete the folder <strong>repos/<?php echo $repo->get_folder();?></strong> and its contents.</li>
    <li>Permanently delete all ARK entries associated with repository #<?php echo $repo_id;?> in MySQL.</li>
  </ol>
  <p><strong>Once deleted, this repository and its finding aids cannot be restored.</strong> If the institution rejoins Archives West, a new repository will need to be created and all finding aids uploaded again.</p>

  <form id="form-repo-delete" method="post" action="<?php echo AW_DOMAIN; ?>/tools/repository-delete-process.php">
    <p><input type="submit" value="Delete the Repository" /></p>
  </form>

<?php
  }
}
else {
  echo '<p>This tool is for admins only.</p>';
}
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
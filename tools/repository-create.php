<?php
// Create a new repository

// Include definitions
$page_title = 'Create Repository';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

if ($user->is_admin()) {
?>
<p>Submitting the form below will:</p>
<ol>
  <li>Make a directory for finding aids within /eads.</li>
  <li>Add a row to the repos table in MySQL.</li>
  <li>Create the database in BaseX for indexing.</li>
</ol>

<?php
// Print error and confirmation messages
if (isset($_SESSION['repo_creation_id'])) {
  if (isset($_SESSION['repo_creation_errors']) && !empty($_SESSION['repo_creation_errors'])) {
    echo print_errors($_SESSION['repo_creation_errors']);
  }
  else if ($_SESSION['repo_creation_id'] != 0) {
    echo '<p class="success">Repository #' . $_SESSION['repo_creation_id'] . ' created!</p>';
  }
  $_SESSION['repo_creation_id'] = 0;
  $_SESSION['repo_creation_errors'] = array();
}

?>

<form id="form-repo-create" class="table-layout" method="post" action="<?php echo AW_DOMAIN; ?>/tools/repository-create-process.php">
  <p><label for="name">Repository Name</label> <input type="text" id="name" name="name" /></p>
  <p><label for="mainagencycode">Main Agency Code</label> <input type="text" id="mainagencycode" name="mainagencycode" /></p>
  <p><label for="oclc">OCLC Symbol</label> <input type="text" id="oclc" name="oclc" /></p>
  <p><label for="folder">Folder Name</label> <input type="text" id="folder" name="folder" /></p>
  <p><input type="submit" value="Create Repository" /></p>
</form>

<?php
}
else {
  echo '<p>This tool is for admins only.</p>';
}
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
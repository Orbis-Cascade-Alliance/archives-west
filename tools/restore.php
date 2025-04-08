<?php
// Restore "deleted" finding aids

// Include definitions
$page_title = 'Restore Deleted Finding Aids';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

$ark = '';
$current_file = '';
if (isset($_GET['ark']) && !empty($_GET['ark'])) {
  $ark = filter_var($_GET['ark'], FILTER_SANITIZE_STRING);
  $finding_aid = new AW_Finding_Aid($ark);
  $current_file = $finding_aid->get_file();
}

if ($user->is_admin()) { 
  // Print repo select form
  include('repo-form.php');
  if ($repo_id != 0) {
    
    // Print error and confirmation messages
    if (isset($_SESSION['restoration_ark']) && !empty($_SESSION['restoration_ark'])) {
      if (isset($_SESSION['restoration_errors']) && !empty($_SESSION['restoration_errors'])) {
        echo print_errors($_SESSION['restoration_errors']);
      }
      else {
        echo '<p class="success">' . $_SESSION['restoration_ark'] . ' successfully restored.</p>';
      }
      $_SESSION['restoration_ark'] = '';
      $_SESSION['restoration_errors'] = array();
    }
    
    $ark_select = build_ark_select($repo_id, 0, 0);
    if ($ark_select) {
      echo '<form id="form-ark" action="' . AW_DOMAIN . '/tools/restore-process.php" method="post">
        <p><label for="ark">Select a deleted ARK from the dropdown below.</label></p>
        <p>' . $ark_select . ' <input type="submit" value="Restore Finding Aid" /></p>
      </form>';
    }
    else {
      echo '<p>This repository has no deleted ARKs to restore.</p>';
    }
  }
}
else {
  echo '<p>This tool is for admins only.</p>';
}

include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
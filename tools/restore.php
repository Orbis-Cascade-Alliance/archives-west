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
}
if ($repo_id != 0) {
  
  // Print error and confirmation messages
  if (isset($_SESSION['restoration_ark']) && !empty($_SESSION['restoration_ark'])) {
    if (isset($_SESSION['restoration_errors']) && !empty($_SESSION['restoration_errors'])) {
      echo print_errors('restoration_errors');
    }
    else {
      echo '<p class="success">' . $_SESSION['restoration_ark'] . ' successfully restored.</p>';
    }
    $_SESSION['restoration_ark'] = '';
    $_SESSION['restoration_errors'] = array();
  }
  
  // Construct ARK select element
  $ark_select = null;
  if ($mysqli = connect()) {
    $empty_result = $mysqli->query('SELECT ark FROM arks WHERE repo_id=' . $repo_id . ' AND active=0');
    if ($empty_result->num_rows > 0) {
      ob_start();
      echo '<form id="form-ark" action="' . AW_DOMAIN . '/tools/restore-process.php" method="post">
        <p><select name="ark">';
      while ($empty_row = $empty_result->fetch_row()) {
        echo '<option value="' . $empty_row[0] . '">' . $empty_row[0] . '</option>';
      }
      echo '</select> <input type="submit" value="Restore Finding Aid" /></p>
      </form>';
      $ark_select = ob_get_contents();
      ob_end_clean();
    }
    $mysqli->close();
  }
  
  $ark_select = build_ark_select($repo_id, 0, 0);
  if ($ark_select) {
    echo '<p>Select a deleted ARK from the dropdown below.</p>';
    echo '<form id="form-ark" action="' . AW_DOMAIN . '/tools/restore-process.php" method="post">
        <p>' . $ark_select . ' <input type="submit" value="Restore Finding Aid" /></p>
      </form>';
  }
  else {
    echo '<p>This repository has no deleted ARKs to restore.</p>';
  }
}

include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
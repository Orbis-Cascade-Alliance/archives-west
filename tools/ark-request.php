<?php
// Request ARK entries in the MySQL database

// Include definitions
$page_title = 'ARK Request';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
include(AW_TOOL_INCLUDES . '/tools-header-end.php');
?>

<p>This tool adds database rows for new Archival Resource Keys (ARKs) to place in EAD files for uploading.</p>

<?php
if ($user->is_admin()) { 
  // Print repo select form
  include('repo-form.php');
}
if ($repo_id != 0) {
?>
  <form id="form-request-arks" method="post" action="<?php echo AW_DOMAIN; ?>/tools/ark-request-process.php">
    <input type="hidden" name="repo_id" value="<?php echo $repo_id; ?>" />
    <p>
      <label for="num">How many ARKs?</label>
      <br />
      <input type="number" id="num" name="num" value="1" />
    </p>
    <p><input type="submit" value="Request ARKs" /></p>
  </form>
<?php
  // Print new arks after submission
  if (isset($_SESSION['new_arks']) && !empty($_SESSION['new_arks'])) {
    $arks = $_SESSION['new_arks'];
    echo '<h2>Results</h2>';
    echo '<table><thead><tr><th>Ark ID</th><th>URL</th></tr></thead><tbody>';
    foreach ($arks as $ark) {
      echo '<tr><td>' . $ark . '</td><td>' . AW_DOMAIN . '/ark:' . $ark . '</td></tr>';
    }
    echo '</tbody></table>';
    $_SESSION['new_arks'] = array();
  }
}

include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
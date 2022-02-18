<?php
// Rebuild BaseX databases

// Include definitions
$page_title = 'Rebuild BaseX Databases';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
<link rel="stylesheet" href="/tools/layout/rebuild.css" />
<script src="/tools/scripts/rebuild.js"></script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

if ($user->is_admin()) {
?>
<div id="results"></div>
<form id="form-rebuild" method="post" action="<?php echo AW_DOMAIN; ?>/tools/rebuild.php">
<?php
  $all_repos = get_all_repos();
  $select = '<p><label for="repo_id">Select a repository to drop from BaseX and rebuild:</label></p><p><select name="repo_id" id="repo_id"><option value="">All Repositories</option>';
  foreach ($all_repos as $repo_id => $repo_info) {
    $select .= '<option value="' . $repo_id . '">' . $repo_info['name'] . '</option>';
  }
  $select .= '</select></p>';
  echo '<p>' . $select . '</p>';
?>
<p><input type="submit" value="Rebuild" /></p>
</form>
<?php
}
else {
  echo '<p>This tool is for admins only.</p>';
}

include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
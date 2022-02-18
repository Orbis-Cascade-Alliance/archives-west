<?php
$all_repos = get_all_repos();
echo '<form id="form-repo" action="' . $current_path . '" method="get"><p><select name="r"><option value="">Select a repository</option>';
foreach ($all_repos as $id => $info) {
  echo '<option value="' . $id . '"';
  if ($id == $repo_id) {
    echo ' selected="selected"';
  }
  echo '>' . $info['name'] . '</option>';
}
echo '</select></p></form>';
?>
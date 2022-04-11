<?php
// Include definitions
$page_title = 'ArchivesSpace Harvester (API)';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
<script src="<?php echo AW_DOMAIN; ?>/tools/scripts/harvest-api.js"></script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');
?>
<p style="font-weight:bold;">This page is for testing by the Archives West Standing Group only.</p>
<?php
if ($user->is_admin()) {
  // Print repo select form
  include('../repo-form.php');
}
if ($repo_id != 0) {
  try {
    $repo = new AW_Repo($repo_id);
    $as_host = $repo->get_as_host_api();
    if (!$as_host) {
      $errors[] = 'This repository does not have an ArchivesSpace host for API requests defined. Add one in the <a href="' . AW_DOMAIN . '/tools/repository-edit.php">Repository Registry Editor</a>.';
    }
    if ($mysqli = connect()) {
      $ongoing_result = $mysqli->query('SELECT id FROM jobs WHERE repo_id=' . $repo_id . ' and complete=0');
      if ($ongoing_result->num_rows > 0) {
        while ($ongoing_row = $ongoing_result->fetch_row()) {
          $job_id = $ongoing_row[0];
        }
        $errors[] = '<a href="'. AW_DOMAIN . '/tools/jobs-view.php?j=' . $job_id . '">Harvest job #' . $job_id . '</a> is in progress. Please wait until it has finished before submitting a new one.';
      }
      $mysqli->close();
    }
  }
  catch (Exception $e) {
    $errors[] = $e->getMessage();
  }
  // Check authentication to ArchivesSpace
  if (!isset($_SESSION['as_session']) || (isset($_SESSION['as_expires']) && time() > isset($_SESSION['as_expires']))) {
    $errors[] = 'ArchivesSpace authentication expired.';
  }
  if (!empty($errors)) {
    echo '<ul class="errors">';
    foreach ($errors as $error) {
      echo '<li>' . $error . '</li>';
    }
    echo '</ul>';
  }
  else {?>
    <p>This tool harvests resources from an ArchivesSpace repository and uploads them to Archives West using the <a href="https://archivesspace.github.io/archivesspace/api/#introduction" target="_blank">API interface</a>.</p>
    <p>Each resource must contain an XML file name in the <strong>EAD ID</strong> field and a URL with a valid ARK in the <strong>EAD Location</strong> field. See <a href="https://www.orbiscascade.org/programs/ulc/archives-and-manuscripts-collections/archivesspace/as-resource-records/">ArchivesSpace Resource Records</a> for instructions and a list of all fields required to comply with the Alliance's EAD Best Practices.</p>
    <p>This tool will import <strong>new finding aids only</strong>. To update an existing finding aid in Archives West, export the EAD from ArchivesSpace and use the ArchivesSpace EAD Converter tool. After validating and checking compliance, locate the finding aid on the homepage and click "Replace" to upload the new file.</p>
    <?php
    // Get repositories
    $as_repo_response = get_as_response($as_host . '/repositories', 'json', $_SESSION['as_session']);
    $as_repos = array();
    foreach ($as_repo_response as $as_repo) {
      $as_repo_uri = (string) $as_repo->uri;
      $exploded_uri = explode('/', $as_repo_uri);
      $as_repo_id = end($exploded_uri);
      $as_repo_name = (string) $as_repo->display_string;
      $as_repos[$as_repo_id] = $as_repo_name;
    }
    if (!empty($as_repos)) {
    ?>
      <form id="form-harvest" action="harvest.php" method="post">
        <select name="as_repo_id" id="as_repo_id"><option value="">Select an ArchivesSpace Repository</option>
        <?php
        foreach ($as_repos as $as_repo_id => $as_repo_name) {
          echo '<option value="' . $as_repo_id . '">' . $as_repo_name . '</option>';
        }
        ?>
        </select>
        <p><input type="submit" value="Harvest Finding Aids" /></p>
      </form>
      <div id="results"></div>
    <?php
    }
    else {
      echo '<p class="errors">No repositories found for ArchivesSpace host ' . $as_host . '</p>';
    }
  }
}
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
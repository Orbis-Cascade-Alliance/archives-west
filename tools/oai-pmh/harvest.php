<?php
// Include definitions
$page_title = 'ArchivesSpace Harvester';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/tools/layout/harvest.css" />
<script src="<?php echo AW_DOMAIN; ?>/tools/scripts/harvest-oaipmh.js"></script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

if ($user->is_admin()) {
  // Print repo select form
  include('../repo-form.php');
}
if ($repo_id != 0) {
  try {
    $repo = new AW_Repo($repo_id);
    $as_host = $repo->get_as_host();
    if (!$as_host) {
      $errors[] = 'This repository does not have an ArchivesSpace host for OAI-PMH requests defined. Add one in the <a href="' . AW_DOMAIN . '/tools/repository-edit.php">Repository Registry Editor</a>.';
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
  if (!empty($errors)) {
    echo print_errors($errors);
  }
  else {
    ?>
    <p>This tool harvests resources from an ArchivesSpace repository and uploads them to Archives West using the <a href="https://archivesspace.github.io/tech-docs/architecture/oai-pmh/" target="_blank">OAI-PMH interface</a>.</p>
    <p>Each resource must contain an XML file name in the <strong>EAD ID</strong> field and a URL with a valid ARK in the <strong>EAD Location</strong> field. See <a href="https://www.orbiscascade.org/programs/ulc/archives-and-manuscripts-collections/archivesspace/as-resource-records/">ArchivesSpace Resource Records</a> for instructions and a list of all fields required to comply with the Alliance's EAD Best Practices.</p>
    <p>Unpublished and suppressed ArchivesSpace resources cannot be harvested through this tool.</p>
    <form id="form-harvest-single" class="tab-contents" action="harvest-process-single.php" method="post">
      <p>Enter one of the following in the field below:</p>
      <ul>
        <li>The direct link to the published resource, e.g., https://pinestate.libraryhost.com/repositories/3/resources/22</li>
        <li>The resource URI under Basic Information, e.g., /repositories/3/resources/22</li>
      </ul>
      <p>
        <label for="as_resource">Published Link or URI:</label>
        <input type="text" name="as_resource" id="as_resource" />
      </p>
      <p>
        <input type="checkbox" name="replace_file" id="replace_file" />
        <label for="replace_file" class="inline">Replace existing file</label>
      </p>
      <p><input type="submit" value="Harvest Finding Aid" /></p>
    </form>
    <div id="results"></div>
    <div id="dialog-error" title="Error">Date format must be YYYY-MM-DD</div>
<?php
  }
}
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
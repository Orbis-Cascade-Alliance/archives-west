<?php
// Include definitions
$page_title = 'ArchivesSpace Harvester (OAI-PMH)';
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
    // Get tab
    $tab = 'single';
    /*if (isset($_GET['tab']) && $_GET['tab'] == 'set') {
      $tab = 'set';
    }*/
    ?>
    <p>This tool harvests resources from an ArchivesSpace repository and uploads them to Archives West using the <a href="https://archivesspace.github.io/tech-docs/architecture/oai-pmh/" target="_blank">OAI-PMH interface</a>.</p>
    <p>Each resource must contain an XML file name in the <strong>EAD ID</strong> field and a URL with a valid ARK in the <strong>EAD Location</strong> field. See <a href="https://www.orbiscascade.org/programs/ulc/archives-and-manuscripts-collections/archivesspace/as-resource-records/">ArchivesSpace Resource Records</a> for instructions and a list of all fields required to comply with the Alliance's EAD Best Practices.</p>
    <p>Unpublished and suppressed ArchivesSpace resources cannot be harvested through this tool.</p>
    <!--<ul id="form-tabs" class="tabs">
      <li<?php if ($tab == 'single') {echo ' class="active"';}?>><a href="?tab=single">Single Resource by URL</a></li>
      <li<?php if ($tab == 'set') {echo ' class="active"';}?>><a href="?tab=set">Set of Resources</a></li>
    </ul>-->
    <?php
    if ($tab == 'single') {
    ?>
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
    <?php }
    else if ($tab == 'set') {
      // Get sets
      $as_sets_xml = get_as_oaipmh($as_host . '/oai?verb=ListSets');
      $as_sets = array();
      foreach ($as_sets_xml->ListSets->set as $set) {
        $set_spec = (string) $set->setSpec;
        $set_name = (string) $set->setName;
        $as_sets[$set_spec] = $set_name;
      }
      // Get start date
      $start_date = null;
      if ($mysqli = connect()) {
        $jobs_result = $mysqli->query('SELECT MAX(date) FROM jobs WHERE repo_id=' . $repo_id . ' GROUP BY repo_id');
        if ($jobs_result->num_rows == 1) {
          while ($jobs_row = $jobs_result->fetch_row()) {
            $start_date = date('Y-m-d', strtotime($jobs_row[0]));
          }
        }
      }
      if (!$start_date) {
        // Get date from Identify
        $as_id_xml = get_as_oaipmh($as_host . '/oai?verb=Identify');
        $date = (string) $as_id_xml->Identify->earliestDateStamp;
        $start_date = date('Y-m-d', strtotime($date));
      }
    ?>
    <form id="form-harvest-set" class="tab-contents" action="harvest-process-set.php" method="post">
      <label for="as_set">Set:</label><select name="as_set" id="as_set"><option value="">All Sets</option>
      <?php
      foreach ($as_sets as $set_spec => $set_name) {
        echo '<option value="' . $set_spec . '">' . $set_name . '</option>';
      }
      ?>
      </select>
      <p><label for="start_date">Harvest resources modified since:</label><input type="text" class="date" id="start_date" name="start_date" value="<?php echo $start_date; ?>" /></p>
      <p>
        <input type="checkbox" name="replace_file" id="replace_file" />
        <label for="replace_file" class="inline">Replace existing files</label>
      </p>
      <p><input type="submit" value="Harvest Finding Aids" /></p>
    </form>
    <?php } ?>
    <div id="results"></div>
    <div id="dialog-error" title="Error">Date format must be YYYY-MM-DD</div>
<?php
  }
}
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
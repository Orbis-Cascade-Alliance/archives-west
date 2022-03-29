<?php
// Print the tools homepage

// Include definitions
$page_title = '';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');

// Get maintenance mode status
$maintenance_mode = check_maintenance_mode();

// Get tab
$tab = 'f';
if (isset($_GET['tab']) && $_GET['tab']=='j') {
  $tab = 'j';
}

// Get sort order and direction
$order = 'date DESC';
if ((isset($_GET['sort']) && !empty($_GET['sort'])) && (isset($_GET['dir']) && !empty($_GET['dir']))) {
  $order = $_GET['sort'] . ' ' . $_GET['dir'];
  $_SESSION['order'] = $order;
}
else if (isset($_SESSION['order'])) {
  $order = $_SESSION['order'];
}
?>
  <link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/tools/layout/index.css" />
  <script src="<?php echo AW_DOMAIN; ?>/tools/scripts/index.js"></script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

if ($maintenance_mode) {
  echo '<div class="alert">Maintenance mode is on.</div>';
}
?>

<div id="home-columns">

  <div id="submission">
    <h2>Document Submission Tools</h2>
    <ul>
      <li><a href="as2aw.php">ArchivesSpace EAD Converter</a></li>
      <li><a href="ark-request.php">ARK Request</a></li>
      <li><a href="batch.php">Batch Uploader for Document Submission</a></li>
      <li><a href="compliance.php">Compliance Checker</a></li>
      <li><a href="preview.php">Document Preview</a></li>
      <li><a href="upload.php">Document Submission</a></li>
      <li><a href="validation.php">Document Validation</a></li>
      <li><a href="repository-edit.php">Repository Registry Editor</a></li>
    </ul>
  </div>

  <div id="help">
    <h2>Reports</h2>
    <ul>
      <li><a href="analytics/report.php">Finding Aid Views</a></li>
      <?php if ($repo_id != 0) {?><li><a href="export.php">Export List of Finding Aids</a></li><?php } ?>
    </ul>
    
    <h2>Get Help</h2>
    <ul>
      <li><a href="https://www.orbiscascade.org/programs/ulc/help-request/" target="_blank">Help Request Form</a></li>
      <li><a href="https://drive.google.com/file/d/1kNFMUjlvmhABIgDr7LEplU4Qitx0QjZv/view?usp=sharing" target="_blank">Alliance EAD Best Practices</a></li>
      <li><a href="https://www.orbiscascade.org/programs/ulc/archives-and-manuscripts-collections/ead/" target="_blank">Archives West Tutorials and Documentation</a></li>
      <li><a href="https://www.orbiscascade.org/programs/ulc/archives-and-manuscripts-collections/archivesspace/" target="_blank">ArchivesSpace Tutorials and Documentation</a></li>
    </ul>
  </div>
  
  <?php if ($user->is_admin()) { ?>
  <div id="admin">
    <h2>Administration Tools</h2>
    <h3>Users</h3>
    <ul>
      <li><a href="user-manager.php">User Manager</a></li>
    </ul>
    <h3>Finding Aids</h3>
    <ul>
      <li><a href="delete-batch.php">Batch Deletion</a></li>
      <li><a href="restore.php">Document Restoration</a></li>
    </ul>
    <h3>Repositories</h3>
    <ul>
      <li><a href="repository-create.php">Create Repository</a></li>
      <li><a href="repository-delete.php">Delete Repository</a></li>
    </ul>
    <h3>BaseX</h3>
    <ul>
      <li>
        <a href="maintenance.php">Turn Maintenance Mode
          <?php if ($maintenance_mode) {echo 'Off';} else {echo 'On';} ?>
        </a>
      </li>
      <li><a href="rebuild.php">Rebuild Databases</a></li>
    </ul>
  </div>
  <?php } ?>
  
</div>

<?php
// Print repo select form
if ($user->is_admin()) {
  include('repo-form.php');
}

if ($repo_id != 0) {
  // Print tabs
  echo '<ul id="tabs">';
  foreach (array('f'=>'Finding Aids', 'j' => 'Jobs') as $tab_key => $tab_name) {
    echo '<li';
    if ($tab == $tab_key) {
      echo ' class="active"';
    }
    echo '><a href="?tab=' . $tab_key . '">' . $tab_name . '</a></li>';
  }
  echo '</ul>';
  ?>

  <div id="tab-contents">
    <?php
    // Print tab contents
    $repo = new AW_Repo($repo_id);
    if ($tab == 'f') {
      echo '<h2>Finding Aids in ' . $repo->get_name() . '</h2>';
      echo '<p>Use the table below to view, replace, and delete finding aids for this repository.</p>';
      echo '<div id="results" data-tab="f" data-order="' . $order . '"><div class="loading"></div></div>';
    }
    else if ($tab == 'j') {
      echo '<h2>Jobs for ' . $repo->get_name() . '</h2>';
      echo '<div id="results" data-tab="j"><div class="loading"></div></div>';
    }
    ?>
  </div><!-- end tab-contents -->
<?php } ?>

<div id="dialog-keyword" title="Keyword Filter">
  <p>Filter the finding aids table by exact matches in the Title, ARK, or File columns. The filter is not case sensitive.</p>
</div>
<div id="dialog-delete" title="Delete Finding Aid">
  <p>Are you sure you want to delete <span id="delete-title">this finding aid</span>?</p>
</div>
<div id="dialog-error" title="Error">
  <p>Finding aid <span class="ark"></span> could not be deleted. Submit the <a href="https://www.orbiscascade.org/programs/ulc/help-request/">ULC Help Request Form</a> for assistance.</p>
</div>
<div id="dialog-history" title="History">
  <p>Loading...</p>
</div>
<?php
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
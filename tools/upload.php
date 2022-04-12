<?php
// Print upload file page

// Include definitions
$page_title = 'Document Submission';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/tools/layout/upload.css" />
<script src="<?php echo AW_DOMAIN; ?>/tools/scripts/upload.js"></script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

$ark = '';
$current_file = '';
if (isset($_GET['ark']) && !empty($_GET['ark'])) {
  $ark = filter_var($_GET['ark'], FILTER_SANITIZE_STRING);
  $finding_aid = new AW_Finding_Aid($ark);
  $current_file = $finding_aid->get_file();
}
?>
<p>This tool uploads an EAD to Archives West.</p>
<?php
if ($user->is_admin()) { 
  // Print repo select form
  include('repo-form.php');
}
if ($repo_id != 0) {
  
  // If no ARK, show instructions and dropdown
  if ($ark == '') {
    $ark_select = build_ark_select($repo_id, 1, 1);
    if ($ark_select) {
      echo '<p>Select an unused ARK from the dropdown below.</p>';
      echo '<form id="form-ark" action="' . AW_DOMAIN . '/tools/upload.php" method="get">
        <p>' . $ark_select . ' <input type="submit" value="Use ARK" /></p>
      </form>';
    }
    else {
      echo '<p>This repository has no empty ARKs. Go to <a href="/tools/ark-request.php">ARK Request</a> to create one.</p>';
    }
    echo '<p>To update a document associated with a used ARK, go back to the main page and find the table row for the ARK. Click the "Replace" button in the Actions at the end of the row.</p>
    <p>To preview the transformation of a finding aid, go to <a href="/tools/preview.php">Document Preview</a>.</p>';
  }
  // If ARK, show upload form and confirmation messages
  else {
    echo '<h2>Upload document for ARK ' . $ark . '</h2>';
    if (isset($_SESSION['upload_file']) && $_SESSION['upload_file'] !== null) {
      if (isset($_SESSION['upload_errors']) && !empty($_SESSION['upload_errors'])) {
        echo print_errors('upload_errors');
      }
      else {
        //$now = time();
        //$next_quarter = ceil($now/900)*900;
        //$job_time = date('g:i a', $next_quarter);
        echo '<p class="success">Uploaded ' . $_SESSION['upload_file'] . '.
        <a href="' . AW_DOMAIN . '/ark:' . $ark . '" target="_blank">View in Archives West</a>.';
        //<br />This finding aid will be indexed for searching during the next job at ' . $job_time . '.</p>';
        
      }
      $_SESSION['upload_file'] = null;
      $_SESSION['upload_errors'] = array();
    }
    ?>
    <p>Maximum file size is <strong><?php echo MAX_FILE_SIZE;?></strong>. If your file is larger, submit a <a href="https://www.orbiscascade.org/programs/ulc/help-request/">ULC Help Request</a> for staff to process the file manually.</p>
    <form id="form-upload" action="<?php echo AW_DOMAIN; ?>/tools/upload-process.php" method="post" enctype="multipart/form-data">
      <input type="hidden" name="ark" value="<?php echo $ark; ?>" />
      <p><input type="file" name="ead" id="ead"></p>
      <?php
      if ($current_file != '') {
        echo '<p><input type="checkbox" name="replace" id="replace" value="1" checked="checked"> <label for="replace">Replace existing finding aid? (' . $current_file . ')</label></p>';
      }
      ?>
      <p>
        <input type="button" onclick="preview();" value="Preview Finding Aid" />
        <input type="submit" value="Upload File" name="submit">
      </p>
    </form>
  <?php  
  }
}
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
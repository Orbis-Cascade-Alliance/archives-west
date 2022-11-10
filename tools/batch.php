<?php
// Print upload file page

// Include definitions
$page_title = 'Batch Uploader';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/tools/layout/batch.css" />
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/tools/layout/compliance.css" />
<script src="<?php echo AW_DOMAIN; ?>/tools/scripts/batch.js"></script>
<script src="<?php echo AW_DOMAIN; ?>/tools/scripts/compliance.js"></script>
<script>
  const max_files = <?php echo MAX_FILES; ?>;
</script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

if ($user->is_admin()) { 
  // Print repo select form
  include('repo-form.php');
}
if ($repo_id != 0) {
?>
<p>Drag and drop XML files in the teal box, or click "Browse" to select files on your computer, then click "Upload" to submit them. A report will appear below showing the results of the <a href="validation.php">Document Validation</a>, <a href="compliance.php">Compliance Checker</a>, and <a href="upload.php">Document Upload</a> tools.</p>
<p>You can upload up to <strong><?php echo MAX_FILES; ?></strong> files at once. No file can exceed <strong><?php echo MAX_FILE_SIZE;?></strong>.</p>
<p>Check "Replace existing files" to allow overwrites of previously uploaded finding aids.</p>
<ul>
  <li>The tool will overwrite the finding aids identified by the ARKs in eadheader/eadid/@identifier. Please double-check all ARKs in your files to avoid accidental overwrites.</li>
  <li>File names do not need to match previous uploads.</li>
</ul>
<form id="form-files" action="<?php echo AW_DOMAIN; ?>/tools/batch-process.php" method="post" enctype="multipart/form-data">
  <div class="dropzone">
    <p id="instructions">Drop files here.</p>
    <ul id="list"></ul>
  </div>
  <p>
    <label id="label-manual" for="manual">
    Browse...
      <input type="file" name="manual" id="manual" multiple="multiple" />
    </label>
  </p>
  <p>
    <input type="checkbox" name="replace_files" id="replace_files" />
    <label for="replace_files" class="inline">Replace existing files</label>
  </p>
  <p><input type="submit" id="upload" value="Upload" /></p>
</form>
<div id="report"></div>
<div class="loading"></div>
<div id="dialog-appnote" class="dialog" title="Comments/Application Notes"></div>
<div id="dialog-source" class="dialog" title="Source"></div>
<div id="dialog-error" title="Error">You can upload a maximum of <?php echo MAX_FILES; ?> files per batch.</div>
<?php
}
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
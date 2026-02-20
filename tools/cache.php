<?php
// Generate the HTML cache for a finding aid
// This script is called in the background using the AW_Process class
// February 2026: Used only in development. Replaced by AWS SQS in production.

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');

// Get finding aid from ARK
if (isset($argv[1]) && !empty($argv[1])) {
  $ark = filter_var($argv[1], FILTER_SANITIZE_STRING);
  try {
    $finding_aid = new AW_Finding_Aid($ark);
    // Construct HTML
    ob_start();
    include(AW_INCLUDES . '/header.php');
    if ($finding_aid->is_active()) {
      if ($finding_aid->get_file()) {
        echo '<title>' . $finding_aid->get_title() . ' - ' . SITE_TITLE . '</title>
        <link rel="stylesheet" href="' . AW_DOMAIN . '/layout/finding-aid.css?v=1.3" />
        <link rel="stylesheet" href="' . AW_DOMAIN . '/layout/finding-aid-print.css" />
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
        <script src="' . AW_DOMAIN . '/scripts/jquery.mark.min.js"></script>
        <script src="' . AW_DOMAIN . '/scripts/finding-aid.js?v=1.4"></script>';
        include(AW_INCLUDES . '/header-end.php');
        echo '
        <div id="downloads">
          <button type="button" class="btn" onclick="print_finding_aid()">Print</button>
          <a class="btn" href="' . AW_DOMAIN . '/ark:' . $ark . '/xml" target="_blank" role="button">View XML</a>';
        if ($qr_code = $finding_aid->get_qr_code()) {
          echo ' <a id="btn-qr" class="btn" href="' . $qr_code . '" target="_blank" role="button">QR Code</a>';
        }
        echo '</div>';
        echo $finding_aid->transform();
        echo '<div id="dialog-qr" title="QR Code"><div id="qr-loading">Loading...</div></div>';
        echo '<div id="dialog-actions" title="Item Details">Loading...</div>';
      }
      else {
        echo '<title>Finding Aid Not Found - ' . SITE_TITLE . '</title>';
        include(AW_INCLUDES . '/header-end.php');
        echo '<p>No finding aid could be found for this ARK.</p>';
      }
    }
    else {
      $repo = $finding_aid->get_repo();
      echo '<title>Deleted - ' . SITE_TITLE . '</title>';
      include(AW_INCLUDES . '/header-end.php');
      echo '<p>This finding aid has been deleted by <a href="/contact.php#' . $repo->get_mainagencycode() . '">' . $repo->get_name() . '</a>.</p>';
    }
    include(AW_INCLUDES . '/footer.php');
    $html = ob_get_contents();
    ob_end_clean();
      
    // Write the HTML result to the cache file
    $cache_path = $finding_aid->get_cache_path();
    if (file_exists($cache_path)) {
      unlink($cache_path);
    }
    $fh = fopen($cache_path, 'w');
    fwrite($fh, $html);
    fclose($fh);
    
    // Save file in AWS S3
    $cache_file = $finding_aid->get_qualifier() . '.html';
    $bucket = S3_CACHE;
    if (!empty($bucket)) {
      try {
        $s3 = new AW_S3($bucket['name'], $bucket['region'], $bucket['class'], $bucket['path']);
        $s3->put_source($cache_file, $cache_path);
        // Clear CloudFront cache
        queue_invalidation($cache_file);
      }
      catch (Exception $e) {
        log_error($e->getMessage());
        $mail = new AW_Mail(ADMIN_EMAIL, 'AWS Cache Exception for ' . $ark, $e->getMessage());
        $mail->send();
      }  
    }

    // Set cached value in arks table to 1
    if ($mysqli = connect()) {
      $mysqli->query('UPDATE arks SET cached=1 WHERE ark="' . $ark . '"');
      $mysqli->close();
    }
  }
  catch (Exception $e) {
    log_error($e->getMessage());
    // Mail admin
    $mail = new AW_Mail(ADMIN_EMAIL, 'Cache Exception for ' . $ark, $e->getMessage());
    $mail->send();
    // Set cached value to 2 to indicate an error
    if ($mysqli = connect()) {
      $mysqli->query('UPDATE arks SET cached=2 WHERE ark="' . $ark . '"');
      $mysqli->close();
    }
  }
}
?>


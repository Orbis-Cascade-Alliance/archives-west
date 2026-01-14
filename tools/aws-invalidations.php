<?php
// Submits AWS invalidations in batch
// Necessary to avoid exceeding rate limits

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');

if ($mysqli = connect()) {
  // Get queued files
  $file_results = $mysqli->query('SELECT id, file FROM cf WHERE status=0');
  if ($file_results->num_rows > 0) {
    $bucket = S3_CACHE;
    $bucket_path = $bucket['path'];
    $files = array();
    while ($file_row = $file_results->fetch_assoc()) {
      $files[$file_row['id']] = '/' . $bucket_path . $file_row['file'];
    }
    
    // Clear CloudFront cache
    if (!empty($files)) {
      $distribution = AW_CLOUDFRONT;
      if (!empty($distribution)) {
        $ids = implode(',', array_keys($files));
        try {
          $cf = new AW_CloudFront($distribution['id'], $distribution['region']);
          $cf->create_invalidation(array_values($files));
          // Update table rows
          $mysqli->query('UPDATE cf SET status=1 WHERE id IN (' . $ids . ')');
        }
        catch (Exception $e) {
          log_error($e->getMessage());
          $mail = new AW_Mail(ADMIN_EMAIL, 'AWS Cache Exception', $e->getMessage());
          $mail->send();
          $mysqli->query('UPDATE cf SET status=2 WHERE id IN (' . $ids . ')');
        }
      }
    }
    
  }
  $mysqli->close();
}

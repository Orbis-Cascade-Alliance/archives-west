<?php
// Generate the HTML cache for a finding aid
// This script is called in the background using the AW_Process class

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');

// Get finding aid from ARK
if (isset($argv[1]) && !empty($argv[1])) {
  $ark = filter_var($argv[1], FILTER_SANITIZE_STRING);
  try {
    // Transform the XML with XSL
    $finding_aid = new AW_Finding_Aid($ark);
    if ($finding_aid->get_file()) {
      $transformed = $finding_aid->transform();
      
      // Write the HTML result to the cache file
      $cache_path = $finding_aid->get_cache_path();
      if (file_exists($cache_path)) {
        unlink($cache_path);
      }
      $fh = fopen($cache_path, 'w');
      fwrite($fh, $transformed);
      fclose($fh);
      
      // Set cached value in arks table to 1
      if ($mysqli = connect()) {
        $mysqli->query('UPDATE arks SET cached=1 WHERE ark="' . $ark . '"');
        $mysqli->close();
      }
    }
  }
  catch (Exception $e) {
    log_error($e->getMessage());
    // Mail webmaster
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


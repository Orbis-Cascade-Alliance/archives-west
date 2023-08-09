<?php
// Print the raw XML for a finding aid

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

// Get ARK
if (isset($_GET['ark']) && !empty($_GET['ark'])) {
  $ark = filter_var($_GET['ark'], FILTER_SANITIZE_STRING);
  try {
    $finding_aid = new AW_Finding_Aid($ark);
    // Return XML document
    if (!is_null($finding_aid)) {
      header('Content-Type: text/xml');
      $raw = $finding_aid->get_raw();
      if (stristr($raw, '<?xml-stylesheet')) {
        $raw = preg_replace('/<\?xml-stylesheet[^\?]+\?>/','', $raw);
      }
      echo $raw;
    }
  }
  catch (Exception $e) {
    log_error($e->getMessage());
    header('Location: /404.php');
  }
}
else {
  header('Location: /');
}

?>


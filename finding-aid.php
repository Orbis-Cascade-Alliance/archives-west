<?php
// Print a single finding aid
// Used only in development
// In production, CloudFront serves transformed finding aids from S3

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

// Print page
if (isset($_GET['ark']) && !empty($_GET['ark'])) {
  $ark = filter_var($_GET['ark'], FILTER_SANITIZE_STRING);
  try {
    $finding_aid = new AW_Finding_Aid($ark);
    if ($cache = $finding_aid->get_cache()) {
      echo $cache;
    }
    else if (!$finding_aid->is_active()) {
      header('Location: ' . AW_DOMAIN . '/deleted.php?ark=' . $ark);
    }
    else {
      header('Location: ' . AW_DOMAIN . '/errors/processing.html');
    }
  }
  catch (Exception $e) {
    log_error($e->getMessage());
    header('Location: ' . AW_DOMAIN . '/errors/404.html');
  }
}
else {
  header('Location: /');
}

?>


<?php
// Print a single finding aid

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
    else {
      header('Location: /processing.php');
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

include(AW_INCLUDES . '/footer.php');
?>


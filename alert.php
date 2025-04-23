<?php
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
$allowed_types = array('home', 'finding_aid', 'tools');
if (isset($_GET['type']) && in_array($_GET['type'], $allowed_types)) {
  $type = $_GET['type'];
  $repo_id = 0;
  if (isset($_GET['ark'])) {
    $ark = filter_var($_GET['ark'], FILTER_SANITIZE_STRING);
    $repo_id = get_id_from_ark($ark);
  }
  $alert = new AW_Alert($type, $repo_id);
  if ($message = $alert->get_message()) {
    echo '<div class="alert">' . $message . '</div>';
  }
}
?>
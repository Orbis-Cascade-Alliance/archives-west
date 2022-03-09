<?php
// Processes steps to rebuild BaseX databases

require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

$type = $_POST['type'];
$step = $_POST['step'];
$session = new AW_Session();

if ($type == 'all') {
  switch ($step) {
    case 1:
      // Drop all databases
      $session->drop_dbs();
      $session->drop_text();
      $session->drop_brief();
      $session->drop_facets();
      $session->build_text();
      $session->build_brief();
      $session->build_facets();
      break;
    case 2:
      // Build databases
      $repo_id = filter_var($_POST['repo_id'], FILTER_SANITIZE_NUMBER_INT);
      echo 'Building repo ' . $repo_id . '...' . "\n";
      $session->build_db($repo_id);
      echo $session->print_info();
      $session->optimize_db($repo_id);
      break;
    case 3:
      // Build text databases
      $repo_id = filter_var($_POST['repo_id'], FILTER_SANITIZE_NUMBER_INT);
      echo 'Building text index for ' . $repo_id . '...' . "\n";
      $session->index_text($repo_id);
      break;
    case 4:
      // Build brief database
      $session->index_all_brief();
      break;
    case 5:
      // Build facets
      $session->index_all_facets();
      break;
    case 6:
      // Copy indexes to production
      $session->copy_indexes_to_prod();
    default:
      // Do nothing
  }
 
}
else if ($type == 'repo') {
  $repo_id = filter_var($_POST['repo_id'], FILTER_SANITIZE_NUMBER_INT);
  switch ($step) {
    case 1:
      $session->drop_db($repo_id);
      break;
    case 2:
      $session->build_db($repo_id);
      break;
    case 3:
      $session->optimize_db($repo_id);
      break;
    case 4:
      $session->delete_repo_from_text($repo_id);
      $session->index_text($repo_id);
      break;
    case 5:
      $session->delete_repo_from_brief($repo_id);
      $session->index_brief($repo_id);
      break;
    case 6:
      $session->delete_repo_from_facets($repo_id);
      $session->index_facets($repo_id);      
      break;
    case 7:
      $session->copy_indexes_to_prod();
      break;
    default:
      // Do nothing
  }
}
echo $session->print_info();
?>
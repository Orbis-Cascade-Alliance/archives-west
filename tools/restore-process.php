<?php
require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

// Get user from session
$user = get_session_user();

if (isset($_POST['ark']) && !empty($_POST['ark'])) {
  $ark = filter_var($_POST['ark'], FILTER_SANITIZE_STRING);
  $errors = array();
  if ($finding_aid = new AW_Finding_Aid($ark)) {
    
    // Move the file and index with BaseX
    $file_name = $finding_aid->get_file();
    if ($file_name != '') {
      $repo = $finding_aid->get_repo();
      $repo_id = $repo->get_id();
      $file_path = AW_REPOS . '/' . $repo->get_folder() . '/eads/' . $file_name;
      $trash_path = AW_REPOS . '/' . $repo->get_folder() . '/trash/' . $file_name;
      if (file_exists($trash_path)) {
        if (!file_exists($file_path)) {
          
          // Move the file
          rename($trash_path, $file_path);
          
          // Add to BaseX
          $session = new AW_Session();
          $session->add_document($repo_id, $file_name);
          $session->add_to_brief($repo_id, $file_name);
          $session->add_to_facets($repo_id, $file_name, $ark);
          $session->close();
          
          // Update table row
          if ($mysqli = connect()) {
            $delete_stmt = $mysqli->prepare('UPDATE arks SET active=1 WHERE ark=?');
            $delete_stmt->bind_param('s', $ark);
            $delete_stmt->execute();
            $delete_stmt->close();
            $mysqli->close();
          }
          
          // Start caching process
          $finding_aid->build_cache();
        }
        else {
          $errors[] = 'Another file with this name is in the repository folder.';
        }
      }
    }
    
    // Set SESSION variables
    $_SESSION['restoration_ark'] = $ark;
    $_SESSION['restoration_errors'] = $errors;
    $_SESSION['fa_arks'] = array();
  }
}
header('Location: ' . AW_DOMAIN . '/tools/restore.php');
?>
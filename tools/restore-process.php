<?php
require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

// Get user from session and limit to admins only
$user = get_session_user(true);

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
          try {
            $session = new AW_Session();
            $session->add_document($repo_id, $file_name);
            $session->close();
          }
          catch (Exception $e) {
            $errors[] = 'Error communicating with BaseX to add document.';
          }
          
          if ($mysqli = connect()) {
            // Update arks table
            $delete_stmt = $mysqli->prepare('UPDATE arks SET active=1 WHERE ark=?');
            $delete_stmt->bind_param('s', $ark);
            $delete_stmt->execute();
            $delete_stmt->close();
            
            // Insert into updates table
            $user_id = $user->get_id();
            $action = 'add';
            $existing_result = $mysqli->query('SELECT id FROM updates WHERE ark="' . $ark . '" AND action="' . $action . '" AND complete=0');
            if ($existing_result->num_rows == 0) {
              $insert_stmt = $mysqli->prepare('INSERT INTO updates (user, action, ark) VALUES (?, ?, ?)');
              $insert_stmt->bind_param('iss', $user_id, $action, $ark);
              $insert_stmt->execute();
              $insert_stmt->close();
            }
            $mysqli->close();
          }
          
          // Start index process
          index_next();
          
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
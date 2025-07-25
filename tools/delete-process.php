<?php
// "Delete" a finding aid by marking it inactive and removing it from BaseX
// The file remains in the folder and the row in the database, in case it needs to be recovered

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

// Get user from session
$user = get_session_user();

$type = 'single';
if (isset($_POST['type']) && $_POST['type'] == 'batch') {
  $type = 'batch';
}

if (isset($_POST['ark']) && !empty($_POST['ark'])) {
  $ark = filter_var($_POST['ark'], FILTER_SANITIZE_STRING);
  if ($type == 'batch' && strstr($ark, "\n")) {
    $arks = preg_split("/\r\n|\n|\r/", $ark);
  }
  else {
    $arks = array($ark);
  }
  
  try {
    $session = new AW_Session();
    
    if ($mysqli = connect()) {
      
      // Prepare statements
      $user_id = $user->get_id();
      $action = 'delete';
      $delete_stmt = $mysqli->prepare('UPDATE arks SET active=0 WHERE ark=?');
      $delete_stmt->bind_param('s', $ark);
      $existing_stmt = $mysqli->prepare('SELECT id FROM updates WHERE ark=? AND action=? AND complete=0');
      $existing_stmt->bind_param('ss', $ark, $action);
      $insert_stmt = $mysqli->prepare('INSERT INTO updates (user, action, ark) VALUES (?, ?, ?)');
      $insert_stmt->bind_param('iss', $user_id, $action, $ark);
      
      foreach ($arks as $ark) {
        if ($finding_aid = new AW_Finding_Aid($ark)) {
          
          // Move the file and remove from BaseX
          $file_name = $finding_aid->get_file();
          if ($file_name != '') {
            $repo = $finding_aid->get_repo();
            $repo_id = $repo->get_id();
            $file_path = AW_REPOS . '/' . $repo->get_folder() . '/eads/' . $file_name;
            $trash_path = AW_REPOS . '/' . $repo->get_folder() . '/trash/' . $file_name;
            if (file_exists($file_path)) {
              rename($file_path, $trash_path);
            }
            $session->delete_document($repo_id, $file_name);
          }
        
          // Delete cache
          $finding_aid->delete_cache();
          
          // Update arks table
          $delete_stmt->execute();
          
          // Insert into updates table
          $existing_stmt->execute();
          $existing_result = $existing_stmt->get_result();
          if ($existing_result->num_rows == 0) {
            $insert_stmt->execute();
          }
        }
      }
      $insert_stmt->close();
      $existing_stmt->close();
      $delete_stmt->close();
      $mysqli->close();
    }
    $session->close();
    
    // Start index process
    index_next();
  }
  catch (Exception $e) {
    die('Error communicating with BaseX to delete document. Submit a ULC Help Request.');
  }
  
  // Reset finding aids session variable for homepage
  $_SESSION['fa_arks'] = array();
  
  // Redirect to batch page
  if ($type == 'batch') {
    $_SESSION['fa_deleted'] = $arks;
    header('Location: ' . AW_DOMAIN . '/tools/delete-batch.php');
  }
}
?>
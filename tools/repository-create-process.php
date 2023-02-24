<?php
require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

// Get user from session
$user = get_session_user(true);

// Get POST data
$mainagencycode = '';
$oclc = '';
$name = '';
$folder = '';
if (isset($_POST['mainagencycode']) && !empty($_POST['mainagencycode'])) {
  $mainagencycode = filter_var($_POST['mainagencycode'], FILTER_SANITIZE_STRING);
}
if (isset($_POST['oclc']) && !empty($_POST['oclc'])) {
  $oclc = filter_var($_POST['oclc'], FILTER_SANITIZE_STRING);
}
if (isset($_POST['name']) && !empty($_POST['name'])) {
  $name = filter_var($_POST['name'], FILTER_SANITIZE_STRING);
}
if (isset($_POST['folder']) && !empty($_POST['folder'])) {
  $folder = filter_var($_POST['folder'], FILTER_SANITIZE_STRING);
}

$errors = array();
if ($mainagencycode && $name && $folder) {
  
  // Create the directory with eads, cache, qr, and trash plus tools/jobs
  $repo_path = AW_REPOS . '/' . $folder;
  if (!file_exists($repo_path)) {
    mkdir($repo_path);
    foreach (array('eads', 'cache', 'qr', 'trash', 'jobs') as $child) {
      mkdir($repo_path . '/' . $child);
    }
  }
  else {
    $errors[] = 'A repository folder with the name ' . $folder . ' already exists.';
  }
  
  if (empty($errors)) {
    // Insert row in repos
    $repo_id = 0;
    if ($mysqli = connect()) {
      $insert_stmt = $mysqli->prepare('INSERT INTO repos (mainagencycode, oclc, name, folder) VALUES (?, ?, ?, ?)');
      $insert_stmt->bind_param('ssss', $mainagencycode, $oclc, $name, $folder);
      $insert_stmt->execute();
      $insert_stmt->close();
      $repo_id = $mysqli->insert_id;
      $mysqli->close();
    }
    else {
      $errors[] = 'Could not connect to MySQL.';
    }
    
    // Build the database in BaseX
    if ($repo_id != 0) {
      try {
        $session = new AW_Session();
        $session->build_db($repo_id);
        $session->build_text($repo_id);
        $session->index_text($repo_id);
        $session->index_brief($repo_id);
        $session->index_facets($repo_id);
        $session->copy_indexes_to_prod($repo_id);
        $session->close();
      }
      catch (Exception $e) {
        $errors[] = 'Error communciating with BaseX to build indexes.';
      }
    }
    else {
      $errors[] = 'No repository ID.';
    }
  }
}
else {
  $errors[] = 'Require field(s) missing.';
}

$_SESSION['repo_creation_id'] = $repo_id;
$_SESSION['repo_creation_errors'] = $errors;
header('Location: ' . AW_DOMAIN . '/tools/repository-create.php');
?>
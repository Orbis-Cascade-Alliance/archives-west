<?php
require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}
$errors = array();

// Table deletions
function delete_table($mysqli, $repo_id, $query) {
  $delete_stmt = $mysqli->prepare($query);
  $delete_stmt->bind_param('i', $repo_id);
  $delete_stmt->execute();
  $delete_error = $mysqli->error;
  $delete_stmt->close();
  if ($delete_error) {
    return $delete_error;
  }
  else {
    return true;
  }
}

// Get user from session and limit to admins only
$user = get_session_user(true);

// Get repository information
$repo_id = get_user_repo_id($user);
try {
  $repo = new AW_Repo($repo_id);
}
catch (Exception $e) {
  $errors[] = $e->getMessage();
}

if ($repo) {
  // Delete the file directories in eads, cache, qr, and tools/jobs
  $path = AW_REPOS . '/' . $repo->get_folder();
  if (is_dir($path)) {
    foreach (array('eads', 'cache', 'qr', 'trash', 'jobs', 'temp') as $child) {
      if (is_dir($path . '/' . $child)) {
        $dir = opendir($path . '/' . $child);
        while (($file = readdir($dir)) !== false) {
          if ($file != '.' && $file != '..') {
            unlink($path . '/' . $child . '/' . $file);
          }
        }
        if (rmdir($path . '/' . $child) == false) {
          $errors[] = 'Subfolder ' . $child . ' was not deleted.';
        }
      }
    }
    if (rmdir($path) == false) {
      $errors[] = 'Repository folder was not deleted.';
    }
  }

  // Delete ARKs, jobs, and repository row from MySQL
  if ($mysqli = connect()) {
    $queries = array(
      'DELETE FROM arks WHERE repo_id=?',
      'DELETE FROM harvests WHERE job_id IN (SELECT job_id FROM jobs WHERE repo_id=?)',
      'DELETE FROM alerts WHERE repo_id=?',
      'DELETE FROM jobs WHERE repo_id=?',
      'DELETE FROM users WHERE repo_id=?',
      'DELETE FROM repos WHERE id=?'
    );
    foreach ($queries as $query) {
      $deletion_result = delete_table($mysqli, $repo_id, $query);
      if ($deletion_result !== true) {
        $errors[] = $deletion_result;
        break;
      }
    }
    $mysqli->close();
  }
  else {
    $errors[] = 'Could not connect to MySQL.';
  }
  
  // Remove finding aids from BaseX indexes and drop database
  try {
    $session = new AW_Session();
    $session->drop_text($repo_id);
    $session->drop_text_prod($repo_id);
    $session->delete_repo_from_brief($repo_id);
    $session->delete_repo_from_facets($repo_id);
    $session->drop_db($repo_id); 
    $session->copy_indexes_to_prod();
    $session->close();
  }
  catch (Exception $e) {
    $errors[] = 'BaseX Exception: ' . $e->getMessage();
  }
}

$_SESSION['repo_deletion_id'] = $repo_id;
$_SESSION['repo_deletion_errors'] = $errors;
$_SESSION['repo_id'] = 0;
header('Location: ' . AW_DOMAIN . '/tools/repository-delete.php');
?>
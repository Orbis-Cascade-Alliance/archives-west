<?php
require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}
$errors = array();

// Get user from session
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
    foreach (array('eads', 'cache', 'qr', 'trash', 'jobs') as $child) {
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
    if (rmdir($path) == false) {
      $errors[] = 'Repository folder was not deleted.';
    }
  }

  // Delete ARKs, jobs, and repository row from MySQL
  if ($mysqli = connect()) {
    $ark_delete_stmt = $mysqli->prepare('DELETE FROM arks WHERE repo_id=?');
    $ark_delete_stmt->bind_param('i', $repo_id);
    $ark_delete_stmt->execute();
    $ark_delete_error = $mysqli->error;
    $ark_delete_stmt->close();
    if ($ark_delete_error) {
      $errors[] = $ark_delete_error;
    }
    else {
      $jobs_delete_stmt = $mysqli->prepare('DELETE FROM jobs WHERE repo_id=?');
      $jobs_delete_stmt->bind_param('i', $repo_id);
      $jobs_delete_stmt->execute();
      $jobs_delete_error = $mysqli->error;
      $jobs_delete_stmt->close();
      if ($jobs_delete_error) {
        $errors[] = $jobs_delete_error;
      }
      else {
        $users_delete_stmt = $mysqli->prepare('DELETE FROM users WHERE repo_id=?');
        $users_delete_stmt->bind_param('i', $repo_id);
        $users_delete_stmt->execute();
        $users_delete_error = $mysqli->error;
        $users_delete_stmt->close();
        if ($users_delete_error) {
          $errors[] = $users_delete_error;
        }
        else {
          $repo_delete_stmt = $mysqli->prepare('DELETE FROM repos WHERE id=?');
          $repo_delete_stmt->bind_param('i', $repo_id);
          $repo_delete_stmt->execute();
          $repo_delete_error = $mysqli->error;
          $repo_delete_stmt->close();
          if ($repo_delete_error) {
            $errors[] = $repo_delete_error;
          }
        }
      }
    }
    $mysqli->close();
  }
  else {
    $errors[] = 'Could not connect to MySQL.';
  }
  
  // Remove finding aids from BaseX indexes and drop database
  $session = new AW_Session();
  $session->drop_text($repo_id);
  $session->drop_text_prod($repo_id);
  $session->delete_repo_from_brief($repo_id);
  $session->delete_repo_from_facets($repo_id);
  $session->drop_db($repo_id); 
  $session->copy_indexes_to_prod();
  $session->close();
}

$_SESSION['repo_deletion_id'] = $repo_id;
$_SESSION['repo_deletion_errors'] = $errors;
$_SESSION['repo_id'] = 0;
header('Location: ' . AW_DOMAIN . '/tools/repository-delete.php');
?>
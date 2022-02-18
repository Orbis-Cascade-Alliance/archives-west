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

// Get POST data
$user_id = null;
if (isset($_POST['user_id']) && filter_var($_POST['user_id'], FILTER_VALIDATE_INT) !== false) {
  $user_id = $_POST['user_id'];
}
if ($user_id != null) {
  $username = '';
  $repo_id = '';
  $admin = 0;
  if (isset($_POST['username']) && !empty($_POST['username'])) {
    $username = filter_var($_POST['username'], FILTER_SANITIZE_STRING);
  }
  else {
    $errors[] = 'Username is required.';
  }
  if (isset($_POST['repo_id']) && filter_var($_POST['repo_id'], FILTER_VALIDATE_INT) !== false) {
    $repo_id = $_POST['repo_id'];
    try {
      $repo = new AW_Repo($repo_id);
    }
    catch (Exception $e) {
      $errors[] = $e->getMessage();
    }
  }
  else {
    $errors[] = 'Repository is required.';
  }
  if (isset($_POST['admin']) && $_POST['admin'] == 1) {
    $admin = 1;
  }
  if ($user_id == 0) {
    if (isset($_POST['password']) && !empty($_POST['password'])) {
      $hash = password_hash($_POST['password'], PASSWORD_DEFAULT);
    }
    else {
      $errors[] = 'Password is required.';
    }
  }
  
  if (empty($errors)) {
    if ($mysqli = connect()) {
      // Create user
      if ($user_id == 0) {
        $check_stmt = $mysqli->prepare('SELECT id FROM users WHERE username=?');
        $check_stmt->bind_param('s', $username);
        $check_stmt->execute();
        $check_result = $check_stmt->get_result();
        $check_stmt->close();
        if ($check_result->num_rows > 0) {
          $errors[] = 'A user with this username already exists. See record below.';
        }
        else {
          $insert_stmt = $mysqli->prepare('INSERT INTO users (username, hash, repo_id, admin) VALUES (?, ?, ?, ?)');
          $insert_stmt->bind_param('ssii', $username, $hash, $repo_id, $admin);
          $insert_stmt->execute();
          $insert_stmt->close();
        }
      }
      // Update existing user
      else {
        $update_stmt = $mysqli->prepare('UPDATE users SET username=?, repo_id=?, admin=? WHERE id=?');
        $update_stmt->bind_param('siii', $username, $repo_id, $admin, $user_id);
        $update_stmt->execute();
        $update_stmt->close();
      }
    }
  }
  
  $_SESSION['user_edit_errors'] = $errors;
  $_SESSION['user_edit_type'] = $user_id == 0 ? 'created' : 'edited';
  header('Location: user-edit.php?u=' . $username);
}
?>
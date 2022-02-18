<?php
require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

// Get user from session
$user = get_session_user();

// Get repository
$repo_id = get_user_repo_id($user);

// Generate a random new ARK
function generate_ark() {
  return '80444/xv' . rand(100000, 999999);
}

function ark_exists($check_stmt) {
  $check_stmt->execute();
  $result = $check_stmt->get_result();
  if ($result->num_rows > 0) {
    return true;
  }
  return false;
}

if ($repo_id != 0 && isset($_POST['num']) && !empty($_POST['num'])) {
  $num_arks = filter_var($_POST['num'], FILTER_SANITIZE_NUMBER_INT);
  $arks = array();
  if ($mysqli = connect()) {
    $check_stmt = $mysqli->prepare('SELECT id FROM arks WHERE ark=?');
    $check_stmt->bind_param("s", $ark);
    $insert_stmt = $mysqli->prepare('INSERT INTO arks (ark, repo_id) VALUES (?, ?)');
    $insert_stmt->bind_param("si", $ark, $repo_id);
    foreach (range(1, $num_arks) as $i) {
      $ark = generate_ark();
      while (ark_exists($check_stmt)) {
        $ark = generate_ark();
      }
      $insert_stmt->execute();
      $arks[] = $ark;
    }
  }
  $_SESSION['new_arks'] = $arks;
}
header('Location: /tools/ark-request.php');
?>
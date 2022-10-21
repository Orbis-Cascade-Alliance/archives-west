<?php
session_start();
include(AW_TOOL_INCLUDES . '/tools-functions.php');
$current_path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$exploded_path = explode('/', $current_path);
$current_page = end($exploded_path);
$user = null;
$repo_id = null;
if ($current_page == '') {
  $current_page = 'index.php';
}
// Check tools login
if (!isset($_SESSION['user']) || !is_object($_SESSION['user']) || !$_SESSION['user']->get_username()) {
  if ($current_page != 'login.php') {
    header('Location: ' . AW_DOMAIN . '/tools/login.php?redirect=' . $current_path);
  }
}
else {
  // For ArchivesSpace directory, check AS login
  if (in_array('archivesspace', $exploded_path) && $current_page != 'as-login.php') {
    if (!isset($_SESSION['as_session']) || (isset($_SESSION['as_expires']) && time() > isset($_SESSION['as_expires']))) {
      header('Location: as-login.php');
    }
  }
  
  // Get user from session
  $user = $_SESSION['user'];

  // Get repository
  if ($user) {
    $repo_id = 0;
    if ($user->is_admin()) {
      if (isset($_GET['r']) && !empty($_GET['r'])) {
        $repo_id = filter_var($_GET['r'], FILTER_SANITIZE_NUMBER_INT);
        $_SESSION['repo_id'] = $repo_id;
      }
      else if (isset($_SESSION['repo_id'])) {
        $repo_id = $_SESSION['repo_id'];
      }
    }
    else {
      $repo_id = $user->get_repo_id();
    }
  }
  else {
    die('User not found.');
  }
}
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="description" content="Archives West Management Tools allows participating institutions to manage their finding aids in Archives West.">
    
    <!-- jQuery and jQuery UI -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    
    <!-- Local scripts and styles -->
    <link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/tools/layout/tools.css" />
    <script src="<?php echo AW_DOMAIN; ?>/tools/scripts/tools.js"></script>
    
    <title>
    <?php
    if (isset($page_title) && $page_title != '') {
      echo $page_title . ' - ';
    }
    echo TOOLS_TITLE;
    ?>
    </title>
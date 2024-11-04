<?php
// Print table of finding aids

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();

// Get user from session
if (isset($_SESSION['user'])) {
  $user = $_SESSION['user'];
}
else {
  die();
}

// Declare actions
$actions = array(
  'add' => 'added',
  'replace' => 'replaced',
  'delete' => 'deleted'
);

if (isset($_POST['ark']) && !empty($_POST['ark'])) {
    $ark = filter_var($_POST['ark'], FILTER_SANITIZE_STRING);
    if ($mysqli = connect()) {
      
      // Print unordered list
      echo '<ul class="history">';
      
      // Print update history
      $history_stmt = $mysqli->prepare('SELECT action, date FROM updates WHERE ark=? ORDER BY date DESC');
      $history_stmt->bind_param('s', $ark);
      $history_stmt->execute();
      $history_result = $history_stmt->get_result();
      $history_stmt->close();
      if ($history_result->num_rows > 0) {
          while ($history_row = $history_result->fetch_assoc()) {
            echo '<li>File ' . $actions[$history_row['action']] . ' ' . date('F j, Y g:i a', strtotime($history_row['date'])) . '</li>';
          }
      }
      
      // Print ARK creation date
      $creation_stmt = $mysqli->prepare('SELECT date FROM arks WHERE ark=?');
      $creation_stmt->bind_param('s', $ark);
      $creation_stmt->execute();
      $creation_result = $creation_stmt->get_result();
      $creation_stmt->close();
      if ($creation_result->num_rows == 1) {
        while ($creation_row = $creation_result->fetch_assoc()) {
          echo '<li>ARK created ' . date('F j, Y', strtotime($creation_row['date'])) . '</li>';
        }
      }
      
      // Close unordered list
      echo '</ul>';
      $mysqli->close();
    }
    else {
      echo 'Error connecting to MySQL database.';   
    }
}
else {
  echo 'ARK is required.';
}

?>
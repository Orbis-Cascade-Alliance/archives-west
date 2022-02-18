<?php
// Return page of brief results for a stored search
session_start();
header("Access-Control-Allow-Origin: *");
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

// Get query
$query = '';
if (isset($_POST['q']) && !empty($_POST['q'])) {
  $query = filter_var($_POST['q'], FILTER_SANITIZE_STRING);
}

// Update per_page value in session for future searches
if (isset($_POST['per_page']) && !empty($_POST['per_page'])) {
  $_SESSION['per_page'] = filter_var($_POST['per_page'], FILTER_SANITIZE_NUMBER_INT);
}

// Print new brief records from ARKs
if (isset($_POST['arks']) && !empty($_POST['arks'])) {
  $raw_arks = $_POST['arks'];
  $arks = array();
  foreach ($raw_arks as $raw_ark) {
    $arks[] = filter_var($raw_ark, FILTER_SANITIZE_STRING);
  }
  echo print_brief_records($arks, $query);
}
?>
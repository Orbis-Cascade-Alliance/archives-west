<?php
// Export all finding aids

// Include definitions
$page_title = 'Finding Aids Export';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();

// Get user from session
$user = $_SESSION['user'];

// Get repository
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

if ($repo_id != 0) {
  
  $repo = new AW_Repo($repo_id);
  
  // Get export information from BaseX
  try {
    $session = new AW_Session();
    $query = $session->get_query('get-export.xq');
    $query->bind('d', $repo_id);
    $query->bind('a', '');
    $result_string = $query->execute();
    $query->close();
    $session->close();
    if ($result_string) {
      
      // Place EADs in array for rows
      $eads = array();
      $result_xml = simplexml_load_string($result_string);
      foreach ($result_xml->ead as $ead) {
        $ark = (string) $ead->ark;
        $title = (string) $ead->title;
        $date = (string) $ead->date;
        $modified = (string) $ead->modified;
        $modified = date('Y-m-d', strtotime($modified));
        $collection = (string) $ead->collection;
        $file = (string) $ead->file;
        $eads[] = array($ark, $title, $date, $collection, $file, $modified);
      }
      
      // Return CSV file
      ob_start();
      $file = fopen("php://output", 'w');
      fputcsv($file, array('ARK', 'Title', 'Coverage Dates', 'Collection', 'File', 'Last Modified'));
      foreach ($eads as $row) {
        fputcsv($file, $row);
      }
      fclose($file);
      header('Content-Type: text/csv; charset=utf-8');
      header('Content-Disposition: attachment; filename=' . $repo->get_mainagencycode() . '-' . date('Y-m-d') . '.csv');
      ob_get_flush();
    }
    else {
      throw new Exception('REST response failed.');
    }
  }
  catch (Exception $e) {
    throw new Exception('Error communicating with BaseX to export finding aid information.');
  }
}
else {
  die('No repository selected.');
}
?>
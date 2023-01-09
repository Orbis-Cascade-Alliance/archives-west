<?php
// Use the Analytics Reporting API v4 to get pageviews for repository finding aids within a date range
// Documentation: https://developers.google.com/analytics/devguides/reporting/core/v4

require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();

// Authenticate to Google client and get analytics reporting object
require_once('authenticate.php');
$analytics = new Google_Service_AnalyticsReporting($client);
$view_id = '127666071';

function format_date($date_string) {
  return date('F j, Y', strtotime($date_string));
}

// Get user from session
if (isset($_SESSION['user'])) {
  $user = $_SESSION['user'];
}
else {
  die('Access forbidden.');
}

// Get repository
if ($user->is_admin()) {
  $repo_id = $_SESSION['repo_id'];
}
else {
  $repo_id = $user->get_repo_id();
}
try {
  $repo = new AW_Repo($repo_id);
}
catch (Exception $e) {
  die($e->getMessage());
}

// Get dates
$start_date = null;
$end_date = null;
if (isset($_POST['start']) && !empty($_POST['start'])) {
  $start_date = date('Y-m-d', strtotime($_POST['start']));
  $_SESSION['report_start'] = $start_date;
}
if (isset($_POST['end']) && !empty($_POST['end'])) {
  $end_date = date('Y-m-d', strtotime($_POST['end']));
  $_SESSION['report_end'] = $end_date;
}

if ($start_date && $end_date) {
  $views_by_ark = array();
  $total_views = 0;
  // Get views from MySQL
  if ($mysqli = connect()) {
    $query_stmt = $mysqli->prepare(
      'SELECT ark, SUM(count) as sum
      FROM views
      WHERE ark IN (SELECT ark FROM arks WHERE repo_id=?)
      AND date BETWEEN DATE(?) AND DATE(?)
      GROUP BY ark
      ORDER BY sum DESC'
    );
    $query_stmt->bind_param('iss', $repo_id, $start_date, $end_date);
    $query_stmt->execute();
    $result = $query_stmt->get_result();
    $query_stmt->close();
    if ($result->num_rows > 0) {
      while ($row = $result->fetch_array()) {
        $views_by_ark[$row['ark']] = array('views' => $row['sum']);
        $total_views = $total_views + $row['sum'];
      }
    }
    $mysqli->close();
  }
  
  if (!empty($views_by_ark)) {
        
    // Get titles from brief records
    try {
      $brief_records = get_brief_records(array_keys($views_by_ark));
      foreach ($brief_records as $ark => $brief) {
        $views_by_ark[$ark]['title'] = $brief['title'];
      }
      
      // Print table
      ob_start();
      echo '<h2>Finding Aid Views for ' . $repo->get_name() . ' <span class="no-break">' . format_date($start_date) . '</span> to <span class="no-break">' . format_date($end_date) . '</span></h2>';
      echo '<button class="btn-export" type="button" onclick="export_csv();">Export CSV</button>';
      echo '<p id="total">' . number_format($total_views, 0, '', ',') . ' total views</p>';
      echo '<table id="views-by-ark"><thead><tr><th>ARK</th><th>Title</th><th>Views</th></tr></thead><tbody>';
      foreach ($views_by_ark as $ark => $info) {
        $title = 'Unknown';
        if (isset($info['title'])) {
          $title = $info['title'];
        }
        echo '<tr><td><a href="' . AW_DOMAIN . '/ark:' . $ark . '" target="_blank">' . $ark . '</a></td><td>' . $title . '</td><td>' . $info['views'] . '</td></tr>';
      }
      echo '</tbody></table>';
    }
    catch (Exception $e) {
      echo '<p>' . $e->getMessage() . '</p>';
    }
  }
  else {
    echo '<p>There were no views for finding aids in ' . $repo->get_name() . ' from ' . format_date($start_date) . ' to ' . format_date($end_date) . '.</p>';
  }
}
else {
  echo '<p class="errors">Start and end date are required.</p>';
}

?>
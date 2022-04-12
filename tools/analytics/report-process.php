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

  // Get ARKs for this repository
  $arks = array();
  if ($mysqli = connect()) {
    $ark_stmt = $mysqli->prepare('SELECT ark FROM arks WHERE repo_id=?');
    $ark_stmt->bind_param('i', $repo_id);
    $ark_stmt->execute();
    $ark_result = $ark_stmt->get_result();
    while ($ark_row = $ark_result->fetch_row()) {
      $arks[$ark_row[0]] = true;
    }
    $mysqli->close();
  }
  if ($arks) {
    
    // Create the DateRange object.
    $dateRange = new Google_Service_AnalyticsReporting_DateRange();
    $dateRange->setStartDate($start_date);
    $dateRange->setEndDate($end_date);

    // Create the Dimensions objects
    $pages = new Google_Service_AnalyticsReporting_Dimension();
    $pages->setName("ga:pagePath");

    // Create Dimensions filter clause
    $filters = array();
    foreach (array_keys($arks) as $ark) {
      $filter = new Google_Service_AnalyticsReporting_DimensionFilter();
      $filter->setDimensionName("ga:pagePath");
      $filter->setOperator("PARTIAL");
      $filter->setExpressions($ark);
      $filters[] = $filter;
    }
    $filter_clause = new Google_Service_AnalyticsReporting_DimensionFilterClause();
    $filter_clause->setFilters($filters);
    $filter_clause->setOperator('OR');

    // Create the Metrics object.
    $views = new Google_Service_AnalyticsReporting_Metric();
    $views->setExpression("ga:pageviews");
    $views->setAlias("views");

    // Create the ReportRequest object.
    $request = new Google_Service_AnalyticsReporting_ReportRequest();
    $request->setViewId($view_id);
    $request->setDateRanges($dateRange);
    $request->setDimensions(array($pages));
    $request->setDimensionFilterClauses($filter_clause);
    $request->setMetrics(array($views));
    $request->setPageSize(10000);
    
    // Get response(s)
    try {
      $body = new Google_Service_AnalyticsReporting_GetReportsRequest();
      $body->setReportRequests(array($request));
      $result = $analytics->reports->batchGet($body);
      $report = $result[0];
      $reports = array($report);
      $done = false;
      while (!$done) {
        if ($pageToken = $report->getNextPageToken()) {
          $request->setPageToken($pageToken);
          $body->setReportRequests(array($request));
          $result = $analytics->reports->batchGet($body);
          $report = $result[0];
          $reports[] = $report;
        }
        else {
          $done = true;
        }
      }
    }
    catch (Google_Service_Exception $e) {
      die('The Google API call failed. Try narrowing your date range to a shorter time period.');
    }
    
    if ($reports) {
      $views_by_ark = array();
      $total_views = 0;
      foreach ($reports as $report) {
        $data = $report->getData();
        $rows = $data->getRows();
        foreach ($rows as $reportRow) {
          $dimensions = $reportRow->getDimensions();
          $metrics = $reportRow->getMetrics();
          $values = $metrics[0]->getValues();
          
          // Get views by ARK
          $pageviews = (int) $values[0];
          $path = (string) $dimensions[0];
          $ark = extract_ark($path);
          if ($ark && isset($arks[$ark])) {
            if (!isset($views_by_ark[$ark])) {
              $views_by_ark[$ark]['views'] = $pageviews;
            }
            else {
              $views_by_ark[$ark]['views'] = $views_by_ark[$ark]['views'] + $pageviews;
            } 
            // Add to total_views
            $total_views = $total_views + $pageviews;
          }
        }
      }
      if ($views_by_ark) {
        // Sort by views descending
        uasort($views_by_ark, function($a, $b) {
          return $a['views'] > $b['views'] ? -1 : 1;
        });
        
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
  }
  else {
    echo '<p>No finding aids yet!</p>';
  }
}
else {
  echo '<p class="errors">Start and end date are required.</p>';
}

?>
<?php
// Use the Analytics Data API to save pageviews for finding aids in MySQL
// Documentation: https://developers.google.com/analytics/devguides/reporting/data/v1

require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();

try {
  // Authenticate to Google client and get analytics data object
  require_once('authenticate.php');
  $analytics = new Google_Service_AnalyticsData($client);

  // Construct request
  $date = date('Y-m-d', strtotime('-3 days'));
  $date_range = new Google_Service_AnalyticsData_DateRange([
    'start_date' => $date,
    'end_date' => $date
  ]);
  $dimension = new Google_Service_AnalyticsData_Dimension(['name' => 'pagePath']);
  $metric = new Google_Service_AnalyticsData_Metric(['name' => 'screenPageViews',]);
  $request = new Google_Service_AnalyticsData_RunReportRequest([
    'dateRanges' => [$date_range],
    'dimensions' => [$dimension],
    'metrics' => [$metric]
  ]);

  // Get response
  $response = $analytics->properties->runReport(
    'properties/320496644',
    $request
  );
}
catch (Google_Service_Exception $e) {
  // Mail administrator
  $mail = new AW_Mail('tech@orbiscascade.org', 'Google Analytics Data API call failed for ' . $date, $e->getMessage());
  $mail->send();
  die();
}

// Save to MySQL
if ($response) {
  if ($mysqli = connect()) {
    $insert_stmt = $mysqli->prepare('INSERT INTO views (date, ark, count) VALUES (?, ?, ?)');
    $insert_stmt->bind_param('ssi', $date, $ark, $pageviews);
    $update_stmt = $mysqli->prepare('UPDATE views SET count=count+? WHERE date=? AND ark=?');
    $update_stmt->bind_param('iss', $pageviews, $date, $ark);
    $arks = array();
    foreach ($response->getRows() as $row) {
      $dimensions = $row->getDimensionValues();
      $metrics = $row->getMetricValues();
      $path = (string) $dimensions[0]->value;
      $pageviews = (int) $metrics[0]->value;
      $ark = extract_ark($path);
      if ($ark) {
        if (isset($arks[$ark])) {
          $update_stmt->execute();
        }
        else {
          $arks[$ark] = true;
          $insert_stmt->execute();
        }
      }
    }
    $insert_stmt->close();
    $update_stmt->close();
    $mysqli->close();
  }
}

?>
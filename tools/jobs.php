<?php
// Print table of jobs

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();

// Get user from session
$user = get_session_user();

// Get repository ID
$repo_id = get_user_repo_id($user);

// Query and print
if ($repo_id != 0) {
  
  // Query MySQL
  $jobs = array();
  if ($mysqli = connect()) {
    $job_query = 'SELECT id, type, complete, date FROM jobs WHERE repo_id=' . $repo_id . ' ORDER BY date DESC';
    $job_result = $mysqli->query($job_query);
    if ($job_result->num_rows > 0) {
      while ($job_row = $job_result->fetch_assoc()) {
        $jobs[$job_row['id']] = array(
          'type' => $job_row['type'],
          'date' => $job_row['date'],
          'complete' => $job_row['complete']
        );
      }
    }
    $mysqli->close();
  }

  if (!empty($jobs)) {
    // Print count
    echo '<p>' . number_format(count($jobs), 0, '', ',') . ' job';
    if (count($jobs) != 1) {
      echo 's';
    }
    echo '</p>';

    // Pagination
    echo '<div class="pagination">
      <div class="prev">
        <button type="button">&laquo; Previous</button>
      </div>
      <div class="num-results"></div>
      <div class="next">
        <button type="button">Next &raquo;</button>
      </div>
    </div>';

    // Print table
    $types = get_job_types();
    echo '<table id="jobs"><thead><tr><th>Job ID</th><th>Date</th><th>Type</th><th>Status</th><th>Report</th></tr></thead><tbody>';
    foreach ($jobs as $job_id => $job_info) {
      $status = $job_info['complete'] == 0 ? 'In Progress' : 'Complete';
      echo '<tr>
        <td>' . $job_id . '</td>
        <td class="no-break">' . date('Y-m-d h:i a', strtotime($job_info['date'])) . '</td>
        <td class="no-break">' . $types[$job_info['type']] . '</td>
        <td class="no-break">' . $status . '</td>
        <td><a href="jobs-view.php?j=' . $job_id . '" class="no-break">View Report</a></td></tr>';
    }
    echo '</tbody></table>';
  }
  else {
    echo '<p>No jobs yet!</p>';
  }
  
}

?>
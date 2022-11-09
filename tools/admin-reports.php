<?php
// Print reports for admins

class AW_Admin_Report {
  public $query;
  public $results;
  
  function __construct($query) {
    $this->query = $query;
  }
  
  function get_results() {
    if (!isset($this->results)) {
      if ($mysqli = connect()) {
        $this->results = $mysqli->query($this->query);
        $mysqli->close();
      }
      else {
        throw Exception('Error connecting to MySQL database');
      }
    }
    return $this->results;
  }
  
  function print_results() {
    if ($results = $this->get_results()) {
      if ($results->num_rows > 0) {
        $keys = array();
        $r = 1;
        echo '<table>';
        while ($row = $results->fetch_assoc()) {
          if ($r == 1) {
            echo '<thead><tr>';
            $keys = array_keys($row);
            foreach ($keys as $key) {
              echo '<th>' . $key . '</th>';
            }
            echo '</tr></thead><tbody>';
            $r++;
          }
          echo '<tr>';
          foreach ($keys as $key) {
            echo '<td>' . $row[$key] . '</td>';
          }
          echo '</tr>';
        }
        echo '</tbody></table>';
      }
      else {
        echo '<p>No results.</p>';
      }
    }
  }
}

// Include definitions
$page_title = 'Admin Reports';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
  <link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/tools/layout/admin-reports.css" />
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

if ($user->is_admin()) { 
  
  // Uncached Finding Aids
  echo '<h2>Uncached Finding Aids</h2>';
  $file_query = 'SELECT arks.ark as ARK,
      repos.name as Repository,
      arks.file as file
    FROM arks LEFT JOIN repos ON arks.repo_id = repos.id
    WHERE arks.file <> "" AND arks.active = 1 AND arks.cached <> 1';
  $file_report = new AW_Admin_Report($file_query);
  $file_report->print_results();
  
  // Recent Updates
  echo '<h2>Recent Updates</h2>';
  $update_query = 'SELECT updates.ark as ARK,
      updates.date as Date,
      users.username as Username,
      repos.name as Repository,
      updates.complete as Complete
    FROM updates LEFT JOIN arks ON updates.ark=arks.ark
      LEFT JOIN users ON updates.user = users.id
      LEFT JOIN repos ON arks.repo_id = repos.id
    ORDER BY updates.date DESC
    LIMIT 10';
  $update_report = new AW_Admin_Report($update_query);
  $update_report->print_results();
  
  // Recent Jobs
  echo '<h2>Recent Jobs</h2>';
  $job_query = 'SELECT jobs.date as Date,
      jobs.type as Type,
      users.username as Username,
      repos.name as Repository,
      jobs.complete as Complete
    FROM jobs LEFT JOIN users ON jobs.user = users.id
      LEFT JOIN repos ON jobs.repo_id = repos.id
    ORDER BY date DESC
    LIMIT 10';
  $job_report = new AW_Admin_Report($job_query);
  $job_report->print_results();
    
}
else {
  echo '<p>This tool is for admins only.</p>';
}

include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
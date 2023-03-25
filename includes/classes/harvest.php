<?php
class AW_Harvest {
  public $host;
  public $set;
  public $start;
  public $ids;
  
  function __construct($host, $set = null, $start = null) {
    $this->host = $host;
    $this->set = $set;
    $this->start = $start;
    $this->ids = array();
  }
  
  function get_host() {
    return $this->host;
  }
  
  function get_ids() {
    return $this->ids;
  }
  
  function add_id($id) {
    $ids = $this->get_ids();
    $ids[] = $id;
    $this->ids = $ids;
  }
  
  // Insert identifiers into harvest rows for a job and start process
  function harvest_eads($job_id) {
    $ids = $this->get_ids();
    if ($ids && $mysqli = connect()) {
      $insert_stmt = $mysqli->prepare('INSERT INTO harvests (job_id, resource_id) VALUES (?, ?)');
      $insert_stmt->bind_param('is', $job_id, $resource_id);
      foreach ($ids as $resource_id) {
        $insert_stmt->execute();
      }
      $insert_stmt->close();
      $mysqli->close();
    }
    harvest_next($job_id);
  }
  
}
?>
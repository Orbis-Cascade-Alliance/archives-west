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
    $this->harvest_ids();
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
  
  // Get identifiers from ArchivesSpace
  function harvest_ids() {
    // ADD DATE RESTRICTIONS
    $initial_url = $this->host . '/oai?verb=ListIdentifiers&metadataPrefix=oai_ead';
    if ($this->set != null) {
      $initial_url .= '&set=' . $this->set;
    }
    if ($this->start != null) {
      $initial_url .= '&from=' . $this->start;
    }
    $this->harvest_id($initial_url);
  }
  
  // Add identifier if the header status is not deleted
  function harvest_id($url) {
    $xml = get_as_oaipmh($url);
    if ($xml->ListIdentifiers) {
      $status = (string) $xml->ListIdentifiers->header['status'];
      if ($status != 'deleted') {
        $id = (string) $xml->ListIdentifiers->header->identifier;
        $this->add_id($id);
      }
      if ($token = (string) $xml->ListIdentifiers->resumptionToken) {
        $this->harvest_id($this->get_host() . '/oai?verb=ListIdentifiers&resumptionToken=' . $token);
      }
    }
    else if ($xml->error) {
      $message = (string) $xml->error;
      throw new Exception($message);
    }
    else {
      throw new Exception('An error occurred fetching identifiers from ArchivesSpace.');
    }
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
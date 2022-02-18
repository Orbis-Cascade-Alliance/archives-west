<?php
class AW_Harvest {
  public $host;
  public $set;
  public $eads;
  
  function __construct($host, $set = null) {
    $this->host = $host;
    $this->eads = array();
    $initial_url = $host . '/oai?verb=ListRecords&metadataPrefix=oai_ead';
    if ($set != null) {
      $initial_url .= '&set=' . $set;
    }
    $this->harvest_record($initial_url);
  }
  
  function get_host() {
    return $this->host;
  }
  
  function get_eads() {
    return $this->eads;
  }
  
  // GET PREVIOUSLY IMPORTED IDS FROM MYSQL
  function get_imported_ids() {
    return array();
  }
  
  function add_ead($ead, $id) {
    $current_eads = $this->eads;
    $current_eads[$id] = $ead;
    $this->eads = $current_eads;
  }
  
  function harvest_record($url) {
    $record_xml = get_as_oaipmh($url);
    $record = $record_xml->ListRecords->record;
    $as_id = (string) $record->header->identifier;
    if (!in_array($as_id, $this->get_imported_ids())) {
      $ead = $record->metadata->ead;
      $this->add_ead($ead, $as_id);
    }
    if ($token = (string) $record_xml->ListRecords->resumptionToken) {
      $this->harvest_record($this->get_host() . '/oai?verb=ListRecords&resumptionToken=' . $token);
    }
  }
  
}
?>
<?php
// AW_Repo retrieves information about a repository from the MySQL Database

class AW_Repo {
  public $id;
  public $name;
  public $folder;
  public $mainagencycode;
  public $oclc;
  public $email;
  public $url;
  public $phone;
  public $fax;
  public $address;
  public $collection_info;
  public $copy_info;
  public $visit_info;
  public $rights;
  public $as_host_api;
  public $as_host_oaipmh;
  private $harvesters;
  
  function __construct($repo_id) {
    $this->id = $repo_id;
    if ($mysqli = connect()) {
      $query = 'SELECT * FROM repos WHERE id=' . $repo_id;
      if ($result = $mysqli->query($query)) {
        if ($result->num_rows == 1) {
          while ($row = $result->fetch_assoc()) {
            $this->name = $row['name'];
            $this->folder = $row['folder'];
            $this->mainagencycode = $row['mainagencycode'];
            $this->oclc = $row['oclc'];
            $this->email = $row['email'];
            $this->url = $row['url'];
            $this->phone = $row['phone'];
            $this->fax = $row['fax'];
            $this->address = unserialize(stripslashes($row['address']));
            $this->collection_info = $row['collection'];
            $this->copy_info = $row['copy'];
            $this->visit_info = $row['visit'];
            $this->rights = $row['rights'];
            $this->as_host_api = $row['as_host_api'];
            $this->as_host_oaipmh = $row['as_host_oaipmh'];
          }
        }
        else {
          throw new Exception('Repository not found.');
        }
      }
      else {
        throw new Exception('Error in MySQL query.');
      }
      $mysqli->close();
    }
    else {
      throw new Exception('MySQL connection failed.');
    }
  }
  
  function get_id() {
    return $this->id;
  }
  
  function get_name() {
    return $this->name;
  }
  
  function get_folder() {
    return $this->folder;
  }
  
  function get_mainagencycode() {
    return $this->mainagencycode;
  }
  
  function get_oclc() {
    return $this->oclc;
  }
  
  function get_email() {
    return $this->email;
  }
  
  function get_url() {
    return $this->url;
  }
  
  function get_phone() {
    return $this->phone;
  }
  
  function get_fax() {
    return $this->fax;
  }
  
  function get_address() {
    return $this->address;
  }
  
  function get_collection_info() {
    return $this->collection_info;
  }
  
  function get_copy_info() {
    return $this->copy_info;
  }
  
  function get_visit_info() {
    return $this->visit_info;
  }
  
  function get_rights() {
    return $this->rights;
  }
  
  function get_as_host_api() {
    return $this->as_host_api;
  }
  
  function get_as_host_oaipmh() {
    return $this->as_host_oaipmh;
  }
}

?>
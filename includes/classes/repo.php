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
  public $as_host;
  public $as_prefix;
  public $users;
  
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
            $this->as_host = $row['as_host'];
            $this->as_prefix = $row['as_prefix'];
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
  
  function get_as_host() {
    return $this->as_host;
  }
  
  function get_oaipmh_prefix() {
    if (!$this->as_prefix && $this->get_as_host()) {
      $url = $this->get_as_host() . '/oai?verb=Identify';
      $response = get_as_oaipmh($url);
      if (isset($response->Identify->description->{'oai-identifier'})) {
        $identifier = $response->Identify->description->{'oai-identifier'};
        $scheme = (string) $identifier->scheme;
        $repositoryIdentifier = (string) $identifier->repositoryIdentifier;
        $delimiter = (string) $identifier->delimiter;
        $prefix = $scheme . $delimiter . $repositoryIdentifier;
        if ($mysqli = connect()) {
          $mysqli->query('UPDATE repos SET as_prefix="' . $prefix . '" WHERE id=' . $this->get_id());
          if ($mysqli->error) {
            throw new Exception('Error saving OAI-PMH prefix for this repository.');
          }
          $mysqli->close();
        }
        else {
          throw new Exception('MySQL connection failed.');
        }
        $this->as_prefix = $prefix;
      }
      else {
        throw new Exception('Could not find oai-identifier for this repository.');
      }
    }
    return $this->as_prefix;
  }
  
  function get_users() {
    if (!isset($this->users)) {
      $users = array();
      if ($mysqli = connect()) {
        $user_result = $mysqli->query('SELECT username FROM users WHERE repo_id=' . $this->get_id());
        if ($user_result->num_rows > 0) {
          while ($user_row = $user_result->fetch_row()) {
            $users[$user_row[0]] = new AW_User($user_row[0]);
          }
        }
        $mysqli->close();
      }
      else {
        throw new Exception('MySQL connection failed.');
      }
      $this->users = $users;
    }
    return $this->users;
  }
}

?>
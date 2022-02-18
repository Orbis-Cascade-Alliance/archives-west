<?php
// AW_User retrieves information about a user from the MySQL database

class AW_User {
  
  public $id;
  public $username;
  public $repo_id;
  private $admin;
  
  function __construct($username = '') {
    $this->username = $username;
    if ($username != '' && $mysqli = connect()) {
      $user_result = $mysqli->query('SELECT id, username, repo_id, admin FROM users WHERE username="' . $username . '"');
      if ($user_result->num_rows == 1) {
        while ($user_row = $user_result->fetch_assoc()) {
          $this->id = $user_row['id'];
          $this->repo_id = $user_row['repo_id'];
          $this->admin = $user_row['admin'];
        }
      }
      else {
        throw new Exception('Username not found.');
      }
      $mysqli->close();
    }
  }
  
  // Return the primary ID
  function get_id() {
    return $this->id;
  }
  
  // Return the username
  function get_username() {
    return $this->username;
  }
  
  // Return the repository object
  function get_repo_id() {
    return $this->repo_id;
  }
  
  // Return a boolean value for admin rights
  function is_admin() {
    return ($this->admin == 1) ? true : false;
  }
  
  // Verify a submitted password to authenticate
  function verify($raw_password) {
    if ($mysqli = connect()) {
      $hash_result = $mysqli->query('SELECT hash FROM users WHERE username="' . $this->get_username() . '"');
      if ($hash_result->num_rows == 1) {
        while ($hash_row = $hash_result->fetch_row()) {
          return password_verify($raw_password, $hash_row[0]); 
        }
      }
      $mysqli->close();
    }
    return false;
  }
  
}
?>
<?php
// AW_Alert delivers contents for alert banners

class AW_Alert {

  public $type;
  // "home" - the index page of the public website
  // "finding_aid" - all finding aids for a repository
  // "tools" - homepage of the management tools
  public $repo_id; // Integer
  public $message; // String to display

  function __construct($type, $repo_id = 0) {
    $this->type = $type;
    $this->repo_id = $repo_id;
    $this->get_message();
  }
  
  function get_message() {
    if (!isset($this->message)) {
      $this->message = null;
      if ($mysqli = connect()) {
        $today = date('Y-m-d H:i:s');
        $alert_query = 'SELECT message FROM alerts
          WHERE type="' . $this->type . '"
          AND repo_id=' . $this->repo_id . '
          AND start <= "' . $today . '"
          AND end >= "' . $today . '"
          LIMIT 1';
        if ($result = $mysqli->query($alert_query)) {
          if ($result->num_rows == 1) {
            while ($row = $result->fetch_assoc()) {
              $this->message = $row['message'];
            }
          }
        }
        $mysqli->close();
      }
    }
    return $this->message;
  }
}

?>
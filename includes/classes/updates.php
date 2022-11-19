<?php
// AW_Updates retrieves information about a pending updates from the MySQL database

class AW_Updates {
  
  public $updates;
  public $repos;
  
  function __construct() {
    if ($mysqli = connect()) {
      $updates = array();
      $update_query = 'SELECT updates.id, updates.action, arks.repo_id, arks.ark, arks.file
                        FROM updates JOIN arks ON updates.ark = arks.ark
                        WHERE updates.complete=0';
      $update_result = $mysqli->query($update_query);
      if (!$mysqli->error) {
        if ($update_result->num_rows > 0) {
          while ($update_row = $update_result->fetch_assoc()) {
            $updates[$update_row['action']][$update_row['id']] = array(
              'repo_id' => $update_row['repo_id'],
              'ark' => $update_row['ark'],
              'file' => $update_row['file']
            );
          }
        }
      }
      else {
        throw new Exception($mysqli->error);
      }
      $this->updates = $updates;
      $mysqli->close();
    }
    else {
      throw new Exception('Could not connect to MySQL database.');
    }
  }
  
  // Return updates array
  function get_updates() {
    return $this->updates;
  }
  
  // Get update IDs for all actions
  // Returns string separated by commas for use in MySQL
  function get_ids() {
    $ids = array();
    if ($updates = $this->get_updates()) {
      foreach ($updates as $action => $info) {
        $ids = array_merge($ids, array_keys($info));
      }
    }
    return implode(',', $ids);
  }
  
  // Get DBs and files for an action
  // Returns string {database ID}:{file}|{database ID 2}:{file 2} etc.
  function get_files($action) {
    $files = array();
    if ($updates = $this->get_updates()) {
      $action_updates = $updates[$action];
      foreach ($action_updates as $update) {
        $files[] = $update['repo_id'] . ':' . $update['file'];
      }
    }
    return implode('|', $files);
  }
  
  // Get DBs and arks for an action
  // Returns string {database ID}:{ark}|{database ID 2}:{ark 2} etc.
  function get_arks($action) {
    $arks = array();
    if ($updates = $this->get_updates()) {
      $action_updates = $updates[$action];
      foreach ($action_updates as $update) {
        $arks[] = $update['repo_id'] . ':' . $update['ark'];
      }
    }
    return implode('|', $arks);
  }
  
  // Get repositories affected by this update
  // Returns array of IDs
  function get_repos() {
    if (!isset($this->repos)) {
      $repos = array();
      if ($updates = $this->get_updates()) {
        foreach ($updates as $action => $action_updates) {
          foreach ($action_updates as $update) {
            if (!in_array($update['repo_id'], $repos)) {
              $repos[] = $update['repo_id'];
            }
          }
        }
      }
      $this->repos = $repos;
    }
    return $this->repos;
  }
  
  // Perform index updates
  function update_indexes() {
    if ($updates = $this->get_updates()) {
      $session = new AW_Session();
      foreach ($updates as $action => $info) {
        if ($action == 'delete' || $action == 'replace') {
          $arks = $this->get_arks($action);
          $session->delete_from_text($arks);
          $session->delete_from_brief($arks);
          $session->delete_from_facets($arks);
        }
        if ($action == 'add' || $action == 'replace') {
          $files = $this->get_files($action);
          $session->add_to_text($files);
          $session->add_to_brief($files);
          $session->add_to_facets($files);
        }
      }
      foreach ($this->get_repos() as $repo_id) {
        $session->copy_text_to_prod($repo_id);
      }
      $session->copy_brief_to_prod();
      $session->copy_facets_to_prod();
      $session->close();
      $this->mark_complete();
    }
  }
  
  // Mark updates complete
  // Uses the IDs in WHERE, not the completion column,
  // in case more were added during processing
  function mark_complete() {
    $ids = $this->get_ids();
    if ($mysqli = connect()) {
      $mysqli->query('UPDATE updates SET complete=1 WHERE id in (' . $ids . ')');
      $mysqli->close();
    }
  }
  
}

?>
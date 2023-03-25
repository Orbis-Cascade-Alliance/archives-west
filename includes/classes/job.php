<?php
// AW_Finding_Aid retrieves information about a batch or AS import job

class AW_Job {
  
  public $job_id;
  public $type;
  public $repo_id;
  public $user_id;
  public $arks;
  public $date;
  public $start;
  public $replace;
  public $complete;
  public $message;
  public $report_path;
  
  function __construct($job_id) {
    $this->job_id = $job_id;
    if ($mysqli = connect()) {
      $job_query = 'SELECT type, repo_id, user, date, start, replace_file, complete FROM jobs WHERE id=' . $job_id;
      $job_result = $mysqli->query($job_query);
      if ($job_result->num_rows == 1) {
        while ($job_row = $job_result->fetch_assoc()) {
          $this->type = $job_row['type'];
          $this->repo_id = $job_row['repo_id'];
          $this->user_id = $job_row['user'];
          $this->date = $job_row['date'];
          $this->start = $job_row['start'];
          $this->replace = $job_row['replace_file'];
          $this->complete = $job_row['complete'];
        }
        try {
          $repo = new AW_Repo($this->get_repo_id());
          $this->report_path = AW_REPOS . '/' . $repo->get_folder() . '/jobs/' . $this->get_id() . '.html';
        }
        catch (Exception $e) {
          throw Exception($e->getMessage());
        }
      }
      else {
        throw new Exception('Job #' . $job_id . ' not found.');
      }
      $mysqli->close();
    }
    else {
      throw new Exception('Error in MySQL query.');
    }
  }
  
  function get_id() {
    return $this->job_id;
  }
  
  function get_type() {
    return $this->type;
  }
  
  function get_repo_id() {
    return $this->repo_id;
  }
  
  function get_user_id() {
    return $this->user_id;
  }
  
  function get_date() {
    return $this->date;
  }
  
  function get_start() {
    return $this->start;
  }
  
  function add_start($start_date) {
    if ($mysqli = connect()) {
      $mysqli->query('UPDATE jobs SET start="' . $start_date . '" WHERE id=' . $this->get_id());
      if ($mysqli->error) {
        throw new Exception($mysqli->error);
      }
      $mysqli->close();
    }
    else {
      throw new Exception('MySQL connection error.');
    }
    $this->start = $start_date;
  }
  
  function get_replace() {
    return $this->replace;
  }
  
  function set_replace($bool) {
    if ($mysqli = connect()) {
      $mysqli->query('UPDATE jobs SET replace_file=' . $bool . ' WHERE id=' . $this->get_id());
      $mysqli->close();
    }
    else {
      throw new Exception('MySQL connection error.');
    }
    $this->replace = $bool;
  }
  
  function get_complete() {
    return $this->complete;
  }
  
  function set_complete() {
    if ($mysqli = connect()) {
      $mysqli->query('UPDATE jobs SET complete=1 WHERE id=' . $this->get_id());
      $mysqli->close();
    }
    else {
      throw new Exception('MySQL connection error.');
    }
  }
  
  function set_message($message) {
    $this->message = $message;
  }
  
  function get_message() {
    return $this->message;
  }
  
  function get_report_path() {
    return $this->report_path;
  }
  
  function get_report() {
    $filepath = $this->get_report_path();
    if (file_exists($filepath)) {
      return file_get_contents($filepath);
    }
    else {
      throw new Exception('Report for job #' . $this->get_id() . ' not found.');
    }
  }
  
  // Process an array of file names and contents
  function process_files($files) {
    $process_errors = array();
    // Print message, if set
    $report = $this->get_message();
    foreach ($files as $file_name => $file_contents) {
      $report .= '<h3>' . $file_name . '</h3>';
      // Validate
      if ($validation_result = validate_file($file_contents, $this->get_repo_id())) {
        $report .= '<h4>Validation</h4>';
        if ($validation_result['errors']) {
          $report .= print_errors($validation_result['errors']);
        }
        else {
          $ark = $validation_result['ark'];
          $report .= '<p class="success">' . $file_name . ' for ARK ' . $ark . ' is valid!</p>';
          
          // Print compliance report
          if ($compliance_result = check_compliance($file_contents, 'no')) {
            $report .= '<h4>Compliance Report</h4>';
            if ($compliance_result['errors']) {
              $report .= print_errors($compliance_result['errors']);
            }
            else {
              $report .= '<p><button type="button" class="btn-view" onclick="toggle_cr(this)">View Report</button></p>';
              $report .= '<div class="compliance-report">' . $compliance_result['report'] . '</div>';
              
              // Upload
              if ($upload_result = upload_file($file_contents, $file_name, $ark, $this->get_replace(), $this->get_user_id())) {
                $report .= '<h4>Upload</h4>';
                if ($upload_result['errors']) {
                  $report .= print_errors($upload_result['errors']);
                }
                else {
                  $report .= '<p class="success">Uploaded ' . $file_name . '.
                    <a href="' . AW_DOMAIN . '/ark:' . $ark . '" target="_blank">View in Archives West</a>.</p>';
                }
              }
              else {
                $process_errors[] = 'Error uploading ' . $file_name;
              }
            }
          }
          else {
            $process_errors[] = 'Error checking compliance for ' . $file_name;
          }
        }
      }
      else {
        $process_errors[] = 'Error validating ' . $file_name;
      }
    }
     
    // Save report file
    $fh = fopen($this->get_report_path(), 'a');
    fwrite($fh, $report);
    fclose($fh);
    
    // Return true or errors
    if (empty($process_errors)) {
      return true;
    }
    else {
      return $process_errors;
    }
    
  }
  
}
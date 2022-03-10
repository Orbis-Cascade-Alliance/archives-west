<?php
// AW_Finding_Aid retrieves information about a batch or AS import job

class AW_Job {
  
  public $job_id;
  public $type;
  public $repo_id;
  public $arks;
  public $date;
  public $message;
  public $report_path;
  
  function __construct($job_id) {
    $this->job_id = $job_id;
    if ($mysqli = connect()) {
      $job_query = 'SELECT id, type, repo_id, date FROM jobs WHERE id=' . $job_id;
      $job_result = $mysqli->query($job_query);
      if ($job_result->num_rows == 1) {
        while ($job_row = $job_result->fetch_assoc()) {
          $this->type = $job_row['type'];
          $this->repo_id = $job_row['repo_id'];
          $this->date = $job_row['date'];
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
  
  function get_date() {
    return $this->date;
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
  
  function process_files($files) {
    
    // Print message, if set
    $report = $this->get_message();
    
    for ($f = 0; $f < count($files['name']); $f++) {
      
      // Set type variable to check in each of the scripts before redirecting
      $type = 'batch';
      
      // Create singular file object to pass through other scripts
      $file = array(
        'name' => $files['name'][$f],
        'type' => $files['type'][$f],
        'tmp_name' => $files['tmp_name'][$f],
        'error' => $files['error'][$f],
        'size' => $files['size'][$f]
      );
      
      $report .= '<h3>' . ($f+1) . '. ' . basename($file['name']) . '</h3>';
      
      // Validate
      $_FILES['ead'] = $file;
      include(AW_TOOLS . '/validation-process.php');
      if (isset($_SESSION['validation_file']) && !empty($_SESSION['validation_file'])) {
        $report .= '<h4>Validation</h4>';
        if (isset($_SESSION['validation_errors']) && !empty($_SESSION['validation_errors'])) {
          $report .= print_errors('validation_errors');
        }
        else {
          $ark = $_SESSION['validation_ark'];
          $report .= '<p class="success">' . $_SESSION['validation_file'] . ' for ARK ' . $ark . ' is valid!</p>';
          
          // Print compliance report
          $_POST['all'] = 'no';
          include(AW_TOOLS . '/compliance-process.php');
          if (isset($_SESSION['compliance_report']) && !empty($_SESSION['compliance_report'])) {
            $report .= '<h4>Compliance Report</h4>';
            if (isset($_SESSION['compliance_errors']) && !empty($_SESSION['compliance_errors'])) {
              $report .= print_errors('compliance_errors');
            }
            else {
              $report .= '<p><button type="button" class="btn-view" id="btn-cr' . $f . '" onclick="toggle_cr(\'' . $f . '\')">View Report</button></p>';
              $report .= '<div class="compliance-report" id="cr' . $f . '">' . $_SESSION['compliance_report'] . '</div>';
              
              // Upload
              $_POST['ark'] = $ark;
              include(AW_TOOLS . '/upload-process.php');
              if (isset($_SESSION['upload_file']) && $_SESSION['upload_file'] !== null) {
                $report .= '<h4>Upload</h4>';
                if (isset($_SESSION['upload_errors']) && !empty($_SESSION['upload_errors'])) {
                  $report .= print_errors('upload_errors');
                }
                else {
                  $report .= '<p class="success">Uploaded ' . $_SESSION['upload_file'] . '.</p>';
                }
              }
            }
          }
        }
      }
      // Clear session variables
      $_SESSION['validation_file'] = '';
      $_SESSION['validation_ark'] = '';
      $_SESSION['validation_errors'] = array();
      $_SESSION['compliance_report'] = '';
      $_SESSION['compliance_errors'] = array();
      $_SESSION['upload_file'] = null;
      $_SESSION['upload_errors'] = array();
    }
    
    // Start index process
    index_next();
     
    // Save report file
    $fh = fopen($this->get_report_path(), 'w');
    fwrite($fh, $report);
    fclose($fh);
    
  }
  
}
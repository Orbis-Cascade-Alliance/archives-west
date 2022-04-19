<?php
// Process a batch of EADs harvested from ArchivesSpace

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');

function get_temp_dir($repo) {
  return $temp_dir = AW_REPOS . '/' . $repo->get_folder() . '/temp';
}

function get_temp_filepath($repo, $harvest_id) {
  return get_temp_dir($repo) . '/' . $harvest_id . '.xml';
}

$job_id = 0;
$job = null;
$repo_id = 0;
$harvests = array();
$upload_errors = array();
if (isset($argv[1]) && !empty($argv[1])) {
  $job_id = filter_var($argv[1], FILTER_SANITIZE_NUMBER_INT);

  // Get repository and harvest rows from MySQL
  try {
    $job = new AW_Job($job_id);
    if ($mysqli = connect()) {
      // Get repository
      $repo_result = $mysqli->query('SELECT repo_id FROM jobs WHERE id=' . $job_id);
      if ($repo_result->num_rows == 1) {
        while ($repo_row = $repo_result->fetch_row()) {
          $repo_id = $repo_row[0];
        }
      }
      // Get harvest rows
      $harvest_result = $mysqli->query('SELECT id, resource_id FROM harvests WHERE job_id=' . $job_id . ' AND downloaded=1 AND uploaded=0 LIMIT ' . MAX_FILES);
      if ($harvest_result->num_rows > 0) {
        while ($harvest_row = $harvest_result->fetch_assoc()) {
          $harvests[$harvest_row['id']]['resource'] = $harvest_row['resource_id'];
        }
      }
      $mysqli->close();
    }
  }
  catch (Exception $e) {
    $upload_errors[] = $e->getMessage();
  }
  
  // Process harvested files
  if ($repo_id && !empty($harvests)) {
    $files = array();
    try {
      $repo = new AW_Repo($repo_id);
      if ($mysqli = connect()) {
        $update_stmt = $mysqli->prepare('UPDATE harvests SET ark=? WHERE id=?');
        $update_stmt->bind_param('si', $ark, $harvest_id);
        foreach ($harvests as $harvest_id => $harvest_info) {
          $ead_url = '';
          $ead_filename = '';
          $ark = '';
          $file = get_temp_filepath($repo, $harvest_id);
          if (file_exists($file)) {
            $ead = simplexml_load_file($file);
            if (isset($ead->eadheader->eadid['url'])) {
              $ead_url = (string) $ead->eadheader->eadid['url'];
              if ($ead_filename = (string) $ead->eadheader->eadid) {
                $ead_filename = strtolower($ead_filename);
                if (preg_match('/^[a-z0-9\-\_]+\.xml$/', $ead_filename)) {
                  $harvests[$harvest_id]['file'] = $ead_filename;
                  $ark = extract_ark($ead_url);
                  if ($ark) {
                    // Update ARK column
                    $update_stmt->execute();
                    try {
                      $finding_aid = new AW_Finding_Aid($ark);
                      if ($finding_aid->get_file() == '') {
                        // Convert AS to AW EAD
                        $xml_string = $ead->asXML(); 
                        if ($conversion_result = convert_file($xml_string, $repo->get_mainagencycode())) {
                          if ($conversion_result['errors']) {
                            foreach ($conversion_result['errors'] as $error) {
                              $upload_errors[] = $error;
                            }
                          }
                          else {
                            // Place in files array for job
                            $files[$ead_filename] = $conversion_result['ead'];
                          }
                        }
                        else {
                          $upload_errors[] = 'Error converting ArchivesSpace EAD to Archives West for resource ' . $harvest_info['resource'];
                        }
                      }
                      else {
                        $upload_errors[] = 'ARK ' . $ark . ' is already associated with a file (' . $finding_aid->get_file() . ')';
                      }
                    }
                    catch (Exception $e) {
                      $upload_errors[] = $e->getMessage() . ' for resource ' . $harvest_info['resource'];
                    }
                  }
                  else {
                    $upload_errors[] = 'No ARK found for ArchivesSpace resource ' . $harvest_info['resource'];
                  }
                }
                else {
                  $upload_errors[] = 'Invalid filename <i>' . $ead_filename . '</i> in eadheader/eadid. A filename must have the extension ".xml" and can contain letters, numbers, hyphens (-), and underscores (_) only.';
                }
              }
              else {
                $upload_errors[] = 'No filename found in eadheader/eadid for ArchivesSpace resource ' . $harvest_info['resource'];
              }
            }
            else {
              $upload_errors[] = 'No URL attribute found in eadheader/eadid for ArchivesSpace resource ' . $harvest_info['resource'];
            }
          }
          else {
            $upload_errors[] = 'ArchivesSpace resource ' . $harvest_info['resource'] . ' is not an EAD object.';
          }
        }
        $update_stmt->close();
        $mysqli->close();
      }
    }
    catch (Exception $e) {
      $upload_errors[] = $e->getMessage();
    }
    
    // Batch upload files
    if (!empty($files)) {
      try {
        $process_result = $job->process_files($files);
        foreach ($process_result as $error) {
          $upload_errors[] = $error;
        }
      }
      catch (Exception $e) {
        $upload_errors[] = $e->getMessage();
      }
    }
    
    // Mark harvest rows uploaded or failed
    if ($mysqli = connect()) {
      $upload_stmt = $mysqli->prepare('UPDATE harvests SET uploaded=? WHERE id=?');
      $upload_stmt->bind_param('ii', $uploaded, $harvest_id);
      foreach ($harvests as $harvest_id => $harvest_info) {
        if (isset($harvest_info['file']) && file_exists(AW_REPOS . '/' . $repo->get_folder() . '/eads/' . $harvest_info['file'])) {
          $uploaded = 1;
        }
        else {
          $uploaded = 2;
        }
        $upload_stmt->execute();
        unlink(get_temp_filepath($repo, $harvest_id));
      }
      $mysqli->close();
    }
    else {
      $upload_errors[] = 'MySQL connection error.';
    }

  }
  else {
    $upload_errors[] = 'Could not get harvest information.';
  }
  
  // Print errors to job report
  if ($job && !empty($upload_errors)) {
    $report_path = $job->get_report_path();
    $current_report = file_get_contents($report_path);
    preg_match('/<ul class="errors">(.+)<\/ul>/', $current_report, $matches);
    if ($matches) {
      $error_report = '<ul class="errors">' . $matches[1];
      foreach ($upload_errors as $error) {
        $error_report .= '<li>' . $error . '</li>';
      }
      $error_report .= '</ul>';
      $new_report = str_replace($matches[0], $error_report, $current_report);
    }
    else {
      $new_report = print_errors($upload_errors) . $current_report;
    }
    $fh = fopen($report_path, 'w');
    fwrite($fh, $new_report);
    fclose($fh);
  }
}
?>
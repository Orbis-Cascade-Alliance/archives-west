<?php
// Process an uploaded file

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}
$errors = array();
$file_name = '';

// Get user from session
$user = get_session_user();

// Get ARK
$ark = '';
if (isset($_POST['ark']) && !empty($_POST['ark'])) {
  $ark = filter_var($_POST['ark'], FILTER_SANITIZE_STRING);
}

// Replace boolean
$replace = 0;
if (isset($_POST['replace']) && $_POST['replace'] == 1) {
  $replace = 1;
}
  
if ($ark) {
  if (isset($_FILES['ead']) && !empty($_FILES['ead'])) {
    
    // Get existing finding aid information
    $current_finding_aid = new AW_Finding_Aid($ark);
    $repo = $current_finding_aid->get_repo();
    $repo_id = $repo->get_id();
    
    // Build file path
    $repo_path = AW_REPOS . '/' . $repo->get_folder() . '/eads';
    $to_replace = array(' ');
    $replacements = array('_');
    $file_name = str_replace($to_replace, $replacements, strtolower(basename($_FILES['ead']['name'])));
    $file_path = $repo_path . '/' . $file_name;
    
    // If file with the same name exists, check if it's for the current ARK or a different one
    $upload = true;
    if (file_exists($file_path)) {
      $associated_ark = '';
      if ($mysqli = connect()) {
        $ark_result = $mysqli->query('SELECT ark FROM arks WHERE file="' . $file_name . '"');
        if ($ark_result->num_rows == 1) {
          while ($ark_row = $ark_result->fetch_row()) {
            $associated_ark = $ark_row[0];
          }
        }
        $mysqli->close();
      }
      if ($associated_ark) {
        // If the file with the same name is for the same ARK and we're not replacing it, print error
        if ($associated_ark == $ark && !$replace) {
          $errors[] = 'A file with this name already exists for this ARK.';
          $upload = false;
        }
        // If the file with the same name is for a different ARK, print error whether we're replacing or not
        else if ($associated_ark != $ark) {
          $errors[] = 'A file with the name <strong>' . $file_name . '</strong> is associated with <a href="' . AW_DOMAIN . '/ark:' . $associated_ark . '" target="_blank">' . $associated_ark . '</a>. Change the file name and try again.';
          $upload = false;
        }
      }
    }
    // If a file name exists in the database and we're not replacing it, print error
    else if ($current_finding_aid->get_file() && !$replace) {
      $errors[] = 'This ARK is associated with the file <strong>' . $current_finding_aid->get_file() . '</strong>.';
      $upload = false;
    }

    if ($upload) {
      // Check ARK in file against the ARK submitted
      $xml = simplexml_load_file($_FILES['ead']['tmp_name']);
      $current_file_name = '';
      if ($ark_in_file = (string) $xml->eadheader->eadid['identifier']) {
        $trimmed_ark_in_file = trim($ark_in_file);
        if ($trimmed_ark_in_file != $ark) {
          $errors[] = 'The ARK in the submitted file, <strong>' . $trimmed_ark_in_file . '</strong>, doesn\'t match the ARK selected.';
        }
        else {
          // If replacing and new file name is different, remove old file
          if ($replace) {
            $current_file_name = $current_finding_aid->get_file();
            if ($file_name != $current_file_name) {
              $current_file_path = $repo_path . '/' . $current_file_name;
              if (file_exists($current_file_path)) {
                unlink($current_file_path);
              }
            }
          }
          
          // Save the new file
          rename($_FILES['ead']['tmp_name'], $file_path);
          chmod($file_path, 0644);
          
          if (file_exists($file_path)) {

            // Strip namespaces and add submission date
            $xml_string = file_get_contents($file_path);
            $stripped_string = strip_namespaces($xml_string);
            $new_string = add_submission_date($stripped_string, time());
            if ($new_string != $xml_string) {
              $fh = fopen($file_path, 'w');
              fwrite($fh, $new_string);
              fclose($fh);
            }
            
            if ($mysqli = connect()) {
              // Update arks table
              $update_stmt = $mysqli->prepare('UPDATE arks SET file=? WHERE ark=?');
              $update_stmt->bind_param('ss', $file_name, $ark);
              $update_stmt->execute();
              $update_stmt->close();
              
              // Insert into updates table
              $user_id = $user->get_id();
              $action = $replace ? 'replace' : 'add';
              $existing_result = $mysqli->query('SELECT id FROM updates WHERE ark="' . $ark . '" AND action="' . $action . '" AND complete=0');
              if ($existing_result->num_rows == 0) {
                $insert_stmt = $mysqli->prepare('INSERT INTO updates (user, action, ark) VALUES (?, ?, ?)');
                $insert_stmt->bind_param('iss', $user_id, $action, $ark);
                $insert_stmt->execute();
                $insert_stmt->close();
              }
              $mysqli->close();
            }
            
            // Update BaseX document database
            $session = new AW_Session();
            if ($replace) {
              $session->replace_document($repo_id, $current_file_name, $file_name);
            }
            else {
              $session->add_document($repo_id, $file_name);
            }
            $session->close();
            
            // Start index process
            if (!isset($type) || $type != 'batch') {
              start_index_process();
            }
            
            // Start caching process
            $finding_aid = new AW_Finding_Aid($ark);
            if ($replace) {
              $finding_aid->delete_cache();
            }
            $finding_aid->build_cache();
            
            // Generate QR code
            $finding_aid->get_qr_code();
            
          }
          else {
            $errors[] = 'File could not be moved to final directory.';
          }
        }
      }
      else {
        $errors[] = 'ARK not found in identifier attribute of eadheader/eadid.';
      }
    }
  }
  else {
    $errors[] = 'File is empty.';
  }
}
else {
  $errors[] = 'ARK is required.';
}

// Save upload session variables to pass
$_SESSION['upload_file'] = $file_name;
$_SESSION['upload_errors'] = $errors;
   
if (!isset($type) || $type != 'batch') {
  header('Location: ' . AW_DOMAIN . '/tools/upload.php?ark=' . $ark);
}
?>
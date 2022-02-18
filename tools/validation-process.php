<?php
// Validate an uploaded file

require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

// Get user from session
$user = get_session_user();
 
if (isset($_FILES['ead']) && !empty($_FILES['ead'])) {
  $errors = array();
  $ark = '';

  // Check loading errors
  $file_contents = file_get_contents($_FILES['ead']['tmp_name']);
  $file_contents = strip_namespaces($file_contents);
  $file_contents = add_dtd($file_contents);
  libxml_use_internal_errors(true);
  $doc = new DOMDocument;
  $doc->loadXML($file_contents);
  $errors = add_errors($errors, libxml_get_errors());
  if (!$errors) {
    // Check validation
    if (!$doc->validate()) {
      $errors = add_errors($errors, libxml_get_errors());
    }
    else {
      // Check ARK in file against the ARK submitted
      $eadid = $doc->getElementsByTagName('eadid');
      if ($eadid->length == 0) {
        $errors[] = 'EADID element not found.';
      }
      else if ($eadid->length > 1) {
        $errors[] = 'More than one EADID element found.';
      }
      else {
        $ark = (string) $eadid->item(0)->getAttribute('identifier');
        if ($ark == '') {
          $errors[] = 'EADID identifier attribute not found.';
        }
        else{
          if ($mysqli = connect()) {
            $ark_stmt = $mysqli->prepare('SELECT repo_id FROM arks WHERE ark=?');
            $ark_stmt->bind_param('s', $ark);
            $ark_stmt->execute();
            $ark_result = $ark_stmt->get_result();
            if ($ark_result->num_rows == 0) {
              $errors[] = 'The ARK in this file does not match any database entries. View valid ARKs in the table on the main page and correct the identifier in the EADID element.';
            }
            else if ($ark_result->num_rows > 1) {
              $errors[] = 'The ARK in this file matches multiple ARK database entries. Contact <a href="mailto:webmaster@orbiscascade.org">webmaster@orbiscascade.org</a> to report the issue.';
            }
            else {
              while ($ark_row = $ark_result->fetch_row()) {
                $ark_repo_id = $ark_row[0];
                if ($user->is_admin()) {
                  $user_repo_id = $_SESSION['repo_id'];
                }
                else {
                  $user_repo_id = $user->get_repo_id();
                }
                if ($ark_repo_id != $user_repo_id) {
                  $errors[] = 'The ARK in this file is associated with another institution. View valid ARKs in the table on the main page.';
                }
              }
            }
            $ark_stmt->close();
            $mysqli->close();
          }
        }
      }
    }
  }
  
  $_SESSION['validation_file'] = basename($_FILES['ead']['name']);
  $_SESSION['validation_ark'] = $ark;
  $_SESSION['validation_errors'] = $errors;
  
}
if ($type != 'batch') {
  header('Location: /tools/validation.php');
}
?>
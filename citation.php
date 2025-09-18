<?php
// Print information to cite a record in a finding aid

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

// Get ARK
if (isset($_GET['ark']) && !empty($_GET['ark'])) {
  $ark = filter_var($_GET['ark'], FILTER_SANITIZE_STRING);
  try {
    $finding_aid = new AW_Finding_Aid($ark);
    $repo = $finding_aid->get_repo();
    if (!is_null($finding_aid)) {
      $raw = $finding_aid->get_raw();
      $xml = simplexml_load_string($raw);
      $contributors = array();
      foreach ($xml->archdesc->did->origination->children() as $contributor) {
        $contributors[] = (string) $contributor;
      }
      $info = array(
        'contributors' => implode(', ', $contributors),
        'title' => (string) $xml->archdesc->did->unittitle,
        'repository' => $repo->get_name(),
        'location' => $repo->get_location(),
        'url' => 'https://archiveswest.orbiscascade.org/ark:' . $ark
      );
      echo json_encode($info);
    }
  }
  catch (Exception $e) {
    log_error($e->getMessage());
    echo 'Error generating citation information';
  }
}


?>
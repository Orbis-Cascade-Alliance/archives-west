<?php
// Print the directory list for ArchiveGrid

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

// Construct XML
$repos = get_all_repos();
$xml = simplexml_load_string('<directories></directories>');
foreach ($repos as $repo_id => $repo_info) {
  if ($repo_info['oclc'] != '') {
    if ($files = glob(AW_REPOS . '/' . $repo_info['folder'] . '/eads/*')) {
      $dir = $xml->addChild('dir');
      $dir->addChild('name', $repo_info['folder']);
      $dir->addChild('collection', $repo_info['name']);
      $dir->addChild('symbol', $repo_info['oclc']);
      $eads = $dir->addChild('eads');
      foreach ($files as $file) {
        $exploded_file = explode('/', $file);
        $filename = end($exploded_file);
        $eads->addChild('ead', $filename);
      }
    }
  }
}
header('Content-type: text/xml');
echo $xml->asXML();
?>
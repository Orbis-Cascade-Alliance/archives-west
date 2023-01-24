<?php
// Processes steps to rebuild BaseX databases

require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

// Drop all databases
try {
  $session = new AW_Session();
  $session->drop_dbs();
  $session->drop_all_text();
  $session->drop_all_text_prod();
  $session->drop_brief();
  $session->drop_brief_prod();
  $session->drop_facets();
  $session->drop_facets_prod();
  echo $session->print_info();
  $session->close();
}
catch (Exception $e) {
  die($e->getMessage());
}
?>
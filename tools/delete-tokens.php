<?php
// Delete expired OAI-PMH resumption tokens
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
if ($mysqli = connect()) {
  $mysqli->query('DELETE FROM oai WHERE expiration < NOW()');
  $mysqli->close();
}
?>
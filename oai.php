<?php
// Return XML for OAI-PMH harvesting

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

// Get params
$resumption_token = null;
$verb = null;
$metadata_prefix = null;
$set = null;
$ark = null;
$from = null;
$until = null;
if (isset($_GET['resumptionToken']) && !empty($_GET['resumptionToken'])) {
  $resumption_token = filter_var($_GET['resumptionToken'], FILTER_SANITIZE_STRING);
}
else {
  if (isset($_GET['verb']) && !empty($_GET['verb'])) {
    $verb = filter_var($_GET['verb'], FILTER_SANITIZE_STRING);
  }
  if (isset($_GET['metadataPrefix']) && !empty($_GET['metadataPrefix'])) {
    $metadata_prefix = filter_var($_GET['metadataPrefix'], FILTER_SANITIZE_STRING);
  }
  if (isset($_GET['set']) && !empty($_GET['set'])) {
    $set = filter_var($_GET['set'], FILTER_SANITIZE_STRING);
  }
  if (isset($_GET['identifier']) && !empty($_GET['identifier'])) {
    $ark = filter_var($_GET['identifier'], FILTER_SANITIZE_STRING);
  }
  if (isset($_GET['from']) && !empty($_GET['from'])) {
    $raw_from = filter_var($_GET['from'], FILTER_SANITIZE_STRING);
    $from = date('Y-m-d', strtotime($raw_from));
  }
  if (isset($_GET['until']) && !empty($_GET['until'])) {
    $raw_until = filter_var($_GET['until'], FILTER_SANITIZE_STRING);
    $until = date('Y-m-d', strtotime($raw_until));
  }
}

// Construct object
$oai = new AW_OAI($verb, $metadata_prefix, $set);
if ($resumption_token) {
  $oai->set_resumption_token($resumption_token);
}
else {
  if ($verb == 'GetRecord') {
    if ($ark != null) {
      $oai->set_ark($ark);
    }
    else {
      $oai->write_error('badArgument');
    }
  }
  else if ($verb == 'ListRecords' || $verb == 'ListIdentifiers') {
    if ($from != null) {
      $oai->set_from($from);
    }
    if ($until != null) {
      $oai->set_until($until);
    }
  }
}
$xml_string = $oai->get_result();

// Return XML document
header('Content-Type: text/xml; charset=UTF-8');
echo $xml_string;

?>
<?php
require_once(getenv('AW_HOME') . '/defs.php');
require_once(AW_INCLUDES . '/server-header.php');
require_once(AW_TOOL_INCLUDES . '/tools-functions.php');
if (session_status() === PHP_SESSION_NONE) {
  session_start();
}

// Get user from session
$user = get_session_user();

// Get repo data
$repo_id = get_user_repo_id($user);
$repo = new AW_Repo($repo_id);

// Get POST data
$name = $repo->get_name();
$email = $repo->get_email();
$url = $repo->get_url();
$phone = $repo->get_phone();
$fax = $repo->get_fax();
$address_array = $repo->get_address();
$collection = $repo->get_collection_info();
$copy = $repo->get_copy_info();
$visit = $repo->get_visit_info();
$rights = $repo->get_rights();
$as_host_api = $repo->get_as_host_api();
$as_host_oaipmh = $repo->get_as_host_oaipmh();
if (isset($_POST['name']) && !empty($_POST['name'])) {
  $name = htmlspecialchars(filter_var($_POST['name'], FILTER_SANITIZE_STRING));
  $name = str_replace('&amp;#39;', '\'', $name);
}
if (isset($_POST['email'])) {
  $email = filter_var($_POST['email'], FILTER_SANITIZE_STRING);
}
if (isset($_POST['url'])) {
  $url = filter_var($_POST['url'], FILTER_SANITIZE_STRING);
}
if (isset($_POST['phone'])) {
  $phone = filter_var($_POST['phone'], FILTER_SANITIZE_STRING);
}
if (isset($_POST['fax'])) {
  $fax = filter_var($_POST['fax'], FILTER_SANITIZE_STRING);
}
if (isset($_POST['address'])) {
  $raw_address = filter_var($_POST['address'], FILTER_SANITIZE_STRING);
  $address_array = preg_split("/\r\n|\n|\r/", $raw_address);
}
if (isset($_POST['collection'])) {
  $collection = htmlspecialchars(filter_var($_POST['collection'], FILTER_SANITIZE_STRING));
}
if (isset($_POST['copy'])) {
  $copy = htmlspecialchars(filter_var($_POST['copy'], FILTER_SANITIZE_STRING));
}
if (isset($_POST['visit'])) {
  $visit = htmlspecialchars(filter_var($_POST['visit'], FILTER_SANITIZE_STRING));
}
if (isset($_POST['rights']) && !empty($_POST['rights'])) {
  if ($_POST['rights'] == 'CC Zero' || $_POST['rights'] == 'CC Attribution') {
    $rights = $_POST['rights'];
  }
}
if (isset($_POST['as_host_api'])) {
  $as_host_api = filter_var($_POST['as_host_api'], FILTER_SANITIZE_URL);
}
if (isset($_POST['as_host_oaipmh'])) {
  $as_host_oaipmh = filter_var($_POST['as_host_oaipmh'], FILTER_SANITIZE_URL);
}

if ($mysqli = connect()) {
  // Update repos table
  $serialized_address = $mysqli->real_escape_string(serialize($address_array));
  $update_stmt = $mysqli->prepare('UPDATE repos SET name=?, email=?, url=?, phone=?, fax=?, address=?, collection=?, copy=?, visit=?, rights=?, as_host_api=?, as_host_oaipmh=? WHERE id=?');
  $update_stmt->bind_param('ssssssssssssi', $name, $email, $url, $phone, $fax, $serialized_address, $collection, $copy, $visit, $rights, $as_host_api, $as_host_oaipmh, $repo_id);
  $update_stmt->execute();
  if ($mysqli->error) {
    $errors[] = $mysqli->error;
  }
  $update_stmt->close();
  
  // Update cache if the information printed on finding aids has changed
  if ($repo->get_name() != $name || $repo->get_email() != $email || $repo->get_url() != $url || $repo->get_phone() != $phone || $repo->get_fax() != $fax || $repo->get_address() != $address_array) {
    $arks_stmt = $mysqli->prepare('UPDATE arks SET cached=0 WHERE repo_id=? AND active=1');
    $arks_stmt->bind_param('i', $repo_id);
    $arks_stmt->execute();
    $arks_stmt->close();
    cache_next();
  }
  
  $mysqli->close();
}
else {
  $errors[] = 'Could not connect to MySQL database.';
}

$_SESSION['repo_edit_attempted'] = true;
$_SESSION['repo_edit_errors'] = $errors;

header('Location: ' . AW_DOMAIN . '/tools/repository-edit.php');
?>
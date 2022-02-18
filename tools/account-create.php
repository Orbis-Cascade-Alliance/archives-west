<?php
// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

$users = simplexml_load_file('users.xml');
if ($mysqli = connect()) {
  foreach ($users->user as $user) {
    $name = (string) $user->name;
    $mainagencycode = (string) $user->mainagencycode;
    $repo_id = get_id_from_mainagencycode($mainagencycode);
    $admin = (int) $user->admin;
    $raw_password = (string) $user->password;
    $hash = password_hash($raw_password, PASSWORD_DEFAULT);
    $mysqli->query('INSERT INTO users (name, hash, repo_id, admin) VALUES ("' . $name . '", "' . $hash . '", ' . $repo_id . ', ' . $admin . ')');
  }
}
?>
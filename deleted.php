<?php
// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_INCLUDES . '/header.php');

$repo_name = '';
$repo_mainagencycode = '';
if (isset($_GET['ark']) && !empty($_GET['ark'])) {
  $ark = filter_var($_GET['ark'], FILTER_SANITIZE_STRING);
  if ($repo_id = get_id_from_ark($ark)) {
    try {
      $repo = new AW_Repo($repo_id);
      $repo_name = $repo->get_name();
      $repo_mainagencycode = $repo->get_mainagencycode();
    }
    catch (Exception $e) {
      log_error($e->getMessage());
    }
  }
}

?>

<title>Finding Aid Deleted - <?php echo SITE_TITLE; ?></title>

<?php include(AW_INCLUDES . '/header-end.php'); ?>

<h1>Finding Aid Deleted</h1>

<p>This finding aid has been deleted<?php
  if ($repo_name != '' && $repo_mainagencycode != '') {
    echo ' by <a href="https://archiveswest.orbiscascade.org/contact.php#' . $repo_mainagencycode . '">' . $repo_name . '</a>';
  }
?>.</p>

<?php include(AW_INCLUDES . '/footer.php'); ?>
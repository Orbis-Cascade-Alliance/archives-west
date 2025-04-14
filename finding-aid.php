<?php
// Print a single finding aid

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_INCLUDES . '/header.php');

// Get finding aid from ARK
$title = 'Not Found';
$finding_aid = null;
if (isset($_GET['ark']) && !empty($_GET['ark'])) {
  $ark = filter_var($_GET['ark'], FILTER_SANITIZE_STRING);
  try {
    $finding_aid = new AW_Finding_Aid($ark);
    $title = $finding_aid->get_title();
    if (!$finding_aid->is_active()) {
      $title = 'Deleted';
    }
  }
  catch (Exception $e) {
    log_error($e->getMessage());
    header('Location: /404.php');
  }
}
else {
  header('Location: /');
}
?>

<title><?php echo $title; ?> - <?php echo SITE_TITLE; ?></title>
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/layout/finding-aid.css?v=1.1" />
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/layout/finding-aid-print.css" />
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="<?php echo AW_DOMAIN; ?>/scripts/jquery.mark.min.js"></script>
<script src="<?php echo AW_DOMAIN; ?>/scripts/finding-aid.js?v=1.1"></script>

<?php include(AW_INCLUDES . '/header-end.php'); ?>

<?php
if ($finding_aid != null) {
  $repo = $finding_aid->get_repo();
  if ($finding_aid->is_active()) {
    if ($cache = $finding_aid->get_cache()) {
      if ($alert_message = get_alert('finding_aid', $repo->get_id())) {
        echo '<div class="alert">' . $alert_message . '</div>';
      }
      ?>
      <div id="downloads">
        <a class="btn" href="javascript:void(0)" onclick="print_finding_aid()">Print</a>
        &#160;<a class="btn" href="<?php echo AW_DOMAIN; ?>/ark:<?php echo $ark; ?>/xml" target="_blank" role="button">View XML</a>
        <?php
        if ($qr_code = $finding_aid->get_qr_code()) {
          echo '&#160;<a id="btn-qr" class="btn" href="' . $qr_code . '" target="_blank" role="button">QR Code</a>';
        }
        ?>
      </div>
  <?php
      echo $cache;
    }
    else {
      echo '<p>This finding aid is being processed. Please check back later.</p>';
    }
  }
  else {
    echo '<p>This finding aid has been deleted by <a href="/contact.php#' . $repo->get_mainagencycode() . '">' . $repo->get_name() . '</a>.</p>';
  }
}
else {
  echo '<p>This finding aid could not be found.</p>';
}
?>

<div id="dialog-qr" title="QR Code"><div id="qr-loading">Loading...</div></div>

<?php include(AW_INCLUDES . '/footer.php'); ?>


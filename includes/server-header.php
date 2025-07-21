<?php
// Include classes and functions
require_once(AW_CLASSES . '/alert.php');
require_once(AW_CLASSES . '/finding_aid.php');
require_once(AW_CLASSES . '/job.php');
require_once(AW_CLASSES . '/mail.php');
require_once(AW_CLASSES . '/oai.php');
require_once(AW_CLASSES . '/process.php');
require_once(AW_CLASSES . '/repo.php');
require_once(AW_CLASSES . '/s3.php');
require_once(AW_CLASSES . '/search.php');
require_once(AW_CLASSES . '/session.php');
require_once(AW_CLASSES . '/updates.php');
require_once(AW_CLASSES . '/user.php');
require_once(AW_INCLUDES . '/functions.php');
if ((isset($_SERVER['REMOTE_ADDR']) && !in_array($_SERVER['REMOTE_ADDR'], ADMIN_IPS)) && check_maintenance_mode()) {
  die(get_maintenance_file());
}
?>
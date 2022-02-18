<?php
// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_INCLUDES . '/header.php');
?>

<title>Page Not Found - <?php echo SITE_TITLE; ?></title>

<?php include(AW_INCLUDES . '/header-end.php'); ?>

<h1>Page Not Found</h1>

<p>In summer 2021 the Alliance rebuilt Archives West on a new server, and links to specific pages changed.</p>

<ul>
  <li>Start from the <a href="/">homepage</a> to navigate to the new pages.</li>
  <li>If you're looking for a finding aid, try a <a href="/search.php">new search</a>.</li>
</ul>

<p>Questions? Contact the <a href="mailto:webmaster@orbiscascade.org">Orbis Cascade Alliance IT Manager</a>.</p>

<?php include(AW_INCLUDES . '/footer.php'); ?>
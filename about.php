<?php
// Print About page

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_INCLUDES . '/header.php');
?>

<title>About - <?php echo SITE_TITLE; ?></title>

<?php include(AW_INCLUDES . '/header-end.php'); ?>

<h1>About Us</h1>

<p>This site, which was previously known as Northwest Digital Archives, offers descriptions of archival and manuscript materials held by institutions in Washington, Oregon, Idaho, Alaska, Montana, and Utah. This means that if an institution has a collection&mdash;whether it's digitized or not&mdash;and has created a description of it, you can find out that they have it and use the available options for getting materials.</p>

<p>Similar sites with information about archival collections in the West include:</p>
<ul>
  <li>
    <a href="http://www.oac.cdlib.org/" target="_blank">Archive of California</a>
  </li>
  <li>
    <a href="http://www.lib.utexas.edu/taro/">Texas Archival Resources Online</a>
  </li>
  <li>
    <a href="http://www.azarchivesonline.org/xtf/search">Arizona Archives Online</a>
  </li>
  <li>
    <a href="http://rmoa.unm.edu">Rocky Mountain Online Archive</a>
  </li>
  <li>
    <a href="https://beta.worldcat.org/archivegrid/">ArchiveGrid</a>
  </li>
</ul>

<p>The site was funded by the National Endowment for the Humanities and the National Historical Publications and Records Commission from 2002-2007. It became a program offering of the Orbis Cascade Alliance in 2007 with funding provided by the participating institutions. The program has funded additional development with assistance from the Institute for Museum and Library Services, the National Endowment for the Humanities, and the National Historical Publications and Records Commission.</p>

<?php include(AW_INCLUDES . '/footer.php'); ?>
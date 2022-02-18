<?php
// Print Creative Commons licensing information page

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_INCLUDES . '/header.php');
?>

<title>About - <?php echo SITE_TITLE; ?></title>

<?php include(AW_INCLUDES . '/header-end.php'); ?>

<h1>Creative Commons</h1>

<p><a href="https://creativecommons.org/share-your-work/licensing-types-examples/">Creative Commons Licenses</a> are used on the Finding Aids in Archives West to allow for easier use of the data contained within them. There are two preferred licenses, with exceptions made on a case-by-case basis (as noted in the finding aid).</p>

<p>These licenses cover both the HTML (web) representation of the finding aid data, as well as the underlying EAD XML code. The license <strong>does not include</strong> any images, documents, or other content linked to the finding aid. Use of this data does not connote endorsement by Archives West or its partner institutions.</p>

<p>Please <a href="mailto:orbiscas@orbiscascade.org">contact us</a> if you have any questions and let us know how you’ve used this data for your own research and projects.</p>

<h2>CC Zero</h2>

<p><img src="/layout/images/cc-zero.png" width="88" height="31"><br /><a href="https://creativecommons.org/share-your-work/public-domain/cc0">CC Zero</a> allows users to copy, modify, distribute, remix, and transform our descriptive metadata in any way without asking for permission.</p>

<h2>CC Attribution</h2>

<p><img src="/layout/images/cc-attr.png" width="88" height="31"><br /><a href="https://creativecommons.org/licenses/by/4.0/">CC Attribution</a> gives the same freedom of use as CC0, but asks that users attribute the creator of the original work. If you use data from a finding aid on this site with a CC BY license, attribute the institution that created the finding aid. Attribution helps other people find the original data, as well as the archival materials the data is about.</p>

<?php include(AW_INCLUDES . '/footer.php'); ?>
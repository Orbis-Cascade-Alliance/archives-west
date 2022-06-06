<?php
// Print the sitemap

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

// Construct XML
$xml = simplexml_load_string('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"></urlset>');

// Static pages
$pages = array(
  'index.php',
  'about.php',
  'contact.php',
  'creative-commons.php',
  'help.php',
  'search.php'
);
foreach ($pages as $page) {
  $url = $xml->addChild('url');
  $url->addChild('loc', AW_DOMAIN . '/' . $page);
  $url->addChild('lastmod', date("Y-m-d", filemtime(AW_HTML . '/' . $page)));
  $url->addChild('changefreq', 'yearly');
  $url->addChild('priority', '1.0');
}

// Finding aids
if ($mysqli = connect()) {
  $all_arks = $mysqli->query('SELECT arks.ark, GREATEST(arks.date, COALESCE(max_updates.max_date, 0)) as last_date
    FROM arks LEFT JOIN (
      SELECT ark, MAX(date) as max_date FROM updates GROUP BY ark
    ) as max_updates
    ON arks.ark=max_updates.ark
    WHERE arks.active=1 AND arks.file<>""');
  while ($ark_row = $all_arks->fetch_assoc()) {
    $url = $xml->addChild('url');
    $url->addChild('loc', AW_DOMAIN . '/ark:' . $ark_row['ark']);
    $url->addChild('lastmod', date("Y-m-d", strtotime($ark_row['last_date'])));
    $url->addChild('priority', '0.5');
  }
}

// Save
$to_save= $xml->asXML();
$fh = fopen(AW_HTML . '/sitemap.xml', 'w');
fwrite($fh, $to_save);
fclose($fh);
?>
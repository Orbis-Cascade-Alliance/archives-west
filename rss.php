<?php
// Print RSS for homepage and subscriptions

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

$arks = array();
if ($mysqli = connect()) {
  if ($ark_result = $mysqli->query('SELECT ark, date FROM arks WHERE active=1 AND file<>"" ORDER BY date DESC LIMIT 10')) {
    while ($ark_row = $ark_result->fetch_assoc()) {
      $arks[$ark_row['ark']] = $ark_row['date'];
    }
  }
  $mysqli->close();
}

if (!empty($arks)) {
  
  // Get brief results
  try {
    $brief_records = get_brief_records(array_keys($arks));
  
    // Print RSS
    $rss = simplexml_load_string('<?xml version="1.0" encoding="utf-8"?>
      <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
        <channel>
          <title>Archives West: Recently Added Resources</title>
          <link>' . AW_DOMAIN . '/rss.php</link>
          <description>Information on the most recently uploaded documents created by member institutions</description>
          <language>en-us</language>
          <copyright>(c) Archives West, a program of the Orbis Cascade Alliance</copyright>
          <webMaster>webmaster@orbiscascade.org (Systems Administrator) </webMaster>
          <docs>http://cyber.law.harvard.edu/rss/</docs>
          <atom:link href="' . AW_DOMAIN . '/rss.php" rel="self" type="application/rss+xml" />
        </channel>
      </rss>');
    foreach ($arks as $ark => $date) {
      if (isset($brief_records[$ark])) {
        $result = $brief_records[$ark];
        $link = AW_DOMAIN . '/ark:' . $ark;
        $item = $rss->channel->addChild('item');
        $item->addChild('title', $result['title']);
        $item->addChild('link', $link);
        $item->addChild('author', $result['repo_info']['name']);
        $item->addChild('description', $result['abstract']);
        $item->addChild('guid', $link);
        $item->addChild('pubDate', date('r', strtotime($date)));
      }
    }
    header('Content-Type: text/xml');
    echo $rss->asXML();
  }
  catch (Exception $e) {
    die ($e->getMessage());
  }
}

?>
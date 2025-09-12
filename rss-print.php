<?php
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
ob_start();
echo '<p class="rss-subscribe"><img src="/layout/images/rss.svg" width="16px" alt="RSS icon" /> <a href="' . AW_DOMAIN . '/rss.php' . '">Subscribe to our RSS feed</a></p>';
ob_start();
$content_type = 'text/html';
include(AW_HTML . '/rss.php');
$xml = ob_get_contents();
ob_end_clean();
if ($rss = simplexml_load_string($xml)) {
  foreach ($rss->channel->item as $item) {
    $pubdate = (string) $item->pubDate;
    $date = date('F j, Y g:i a', strtotime($pubdate));
    echo '<div class="rss-item">';
    echo '<p class="rss-date">' . $date . '</p>';
    echo '<p class="rss-title"><a href="' . (string) $item->link . '">' . (string) $item->title . '</a></p>';
    echo '<p class="rss-desc"><i>' . (string) $item->author . '</i>' . (string) $item->description . '</p>';
    echo '</div>';
  }
  $rss_html = ob_get_contents();
  ob_end_clean();
  echo $rss_html;
}
else {
  echo 'Error: Could not get finding aid records from BaseX.';
}
?>
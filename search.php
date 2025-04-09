<?php
// Print search page

session_start();
// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_INCLUDES . '/header.php');

$decoded_query = '';
if (isset($_GET['q']) && !empty($_GET['q'])) {
  $decoded_query = urldecode($_GET['q']);
}
?>

<title>Search<?php if ($decoded_query) {echo ': ' . $decoded_query;}?> - <?php echo SITE_TITLE; ?></title>
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/layout/search.css?v=1.1" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="<?php echo AW_DOMAIN; ?>/scripts/search.js"></script>

<?php include(AW_INCLUDES . '/header-end.php'); ?>

<h1 class="visuallyhidden">Search
<?php if ($decoded_query) {echo ' for <span class="search-term">' . $decoded_query . '</span>';}?>
</h1>

<?php include(AW_INCLUDES . '/search-form.php'); ?>

<div id="results">
  <div class="loading"></div>
</div>

<?php if (empty($_GET)) {?>
<div id="help">
  <h2>Search Tips</h2>
  <ul>
    <li>The engine will search for <strong>all</strong> keywords and phrases in your query. Try adding more words to refine your search, or removing words to get more results.</li>
    <li>You can add double quotes around a phrase for exact searching. For example, the search <i>James Smith</i> will return all finding aids with both the name James and the name Smith, but not necessarily together or in that order. The search <i>"James Smith"</i> will return finding aids with the exact name James Smith.</li>
    <li>If you're getting few or no results, try removing dates and other numbers from your query. Dates might not be spelled out in a finding aid for fulltext searching. For example, a collection could include documents in the range 1900-1950, but a search for 1925 would not match that descriptive text.</li>
  </ul>
</div>
<?php
}

include(AW_INCLUDES . '/footer.php');
?>
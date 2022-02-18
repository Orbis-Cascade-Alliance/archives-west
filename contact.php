<?php
// Print a list of all participating repositories

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_INCLUDES . '/header.php');
?>

<title>Contact - <?php echo SITE_TITLE; ?></title>
<link rel="stylesheet" href="<?php echo AW_DOMAIN; ?>/layout/contact.css" />
<script src="<?php echo AW_DOMAIN; ?>/scripts/contact.js"></script>

<?php include(AW_INCLUDES . '/header-end.php'); ?>

<h1>Contact Participating Repositories</h1>

<?php
if ($mysqli = connect()) {
  if ($repos = $mysqli->query('SELECT id, name, mainagencycode, url, collection, copy, visit FROM repos WHERE id > 0 ORDER BY name ASC')) {
    ob_start();
    $repo_options = array();
    while ($repo = $repos->fetch_assoc()) {
      $repo_options[$repo['mainagencycode']] = $repo['name'];
      echo '<div class="repo" id="' . $repo['mainagencycode'] . '">';
      echo '<h2>';
      if ($repo['url']) {
        echo '<a href="' . $repo['url'] . '" target="_blank">' . $repo['name'] . '</a>';
      }
      else {
        echo $repo['name'];
      }
      echo '</h2>';
      echo '<p class="search-link"><img src="' . AW_DOMAIN . '/layout/images/filing-cabinet.png" alt="Finding Aid icon" /> <a href="' . AW_DOMAIN . '/search.php?r=' . $repo['mainagencycode'] . '">Browse Finding Aids</a></p>';
      if ($repo['collection']) {
        echo '<h3>Collection Information</h3>';
        echo '<div class="pre">' . add_links($repo['collection']) . '</div>';
      }
      if ($repo['copy']) {
        echo '<h3>Copy Information</h3>';
        echo '<div class="pre">'. add_links($repo['copy']) . '</div>';
      }
      if ($repo['visit']) {
        echo '<h3>Visitation Information</h3>';
        echo '<div class="pre">' . add_links($repo['visit']) . '</div>';
      }
      echo '</div><!-- end ' . $repo['mainagencycode'] . '-->';
    }
    $repo_html = ob_get_contents();
    ob_end_clean();
  }
  
  // Print dropdown to jump to repository
  echo '<form id="jump-form" action="' . AW_DOMAIN . '/contact.php"><select name="repo" id="repo-select"><option value="">Jump to...</option>';
  foreach ($repo_options as $mainagencycode => $name) {
    echo '<option value="' . $mainagencycode . '">' . $name . '</option>';
  }
  echo '</select></form>';
  
  // Print repositories
  echo $repo_html;
}
?>

<?php include(AW_INCLUDES . '/footer.php'); ?>
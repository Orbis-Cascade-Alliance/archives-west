<?php
// Connect to mysql
function connect() {
  return new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
}

// Log an error message
function log_error($message) {
  $fh = fopen(AW_HTML . '/log.txt', 'a');
  fwrite($fh, "\n" . date('Y-m-d H:i:s') . "\t" . $message);
  fclose($fh);
}

// Link URLs starting with http/s in a string
function add_links($string) {
  $url_regex = '~(http)s?://[a-z0-9.-]+\.[a-z]{2,3}(/\S*)?(?<!\.)~i';
  return preg_replace($url_regex, '<a href="$0" target="_blank">$0</a>', $string);
}

// Get all facet keys and local names in EAD files
function get_facet_types() {
  return array(
    'geogname' => array('geogname'),
    'name' => array('persname', 'famname', 'corpname'),
    'subject' => array('subject'),
    'occupation' => array('occupation'),
    'genreform' => array('genreform')
  );
}

// Get facet keys and local names as a string for XQuery
function get_facet_string() {
  $facet_strings = array();
  foreach (get_facet_types() as $facet_name => $local_names) {
    $facet_strings[] = $facet_name . ':' . implode(',', $local_names);
  }
  return implode('|', $facet_strings);
}

// Get facet headings
function get_facet_headings() {
  return array(
    'geogname' => 'Place',
    'name' => 'Name',
    'subject' => 'Subject',
    'occupation' => 'Occupation',
    'genreform' => 'Material Type'
  );
}

// Get array of all repo IDs and folders
function get_all_repos() {
  $repos = array();
  if ($mysqli = connect()) {
    $repo_result = $mysqli->query('SELECT id, mainagencycode, oclc, name, folder FROM repos WHERE id > 0 ORDER BY name ASC');
    while ($repo = $repo_result->fetch_assoc()) {
      $repos[$repo['id']] = array(
        'folder' => $repo['folder'],
        'mainagencycode' => $repo['mainagencycode'],
        'oclc' => $repo['oclc'],
        'name' => $repo['name']
      );
    }
    $mysqli->close();
  }
  return $repos;
}

// Get a repository ID from a mainagencycode code
function get_id_from_mainagencycode($mainagencycode) {
  $repo_id = 0;
  if ($mysqli = connect()) {
    $lower_code = strtolower($mainagencycode);
    $repo_stmt = $mysqli->prepare('SELECT id FROM repos WHERE mainagencycode=?');
    $repo_stmt->bind_param('s', $lower_code);
    $repo_stmt->execute();
    $repo_result = $repo_stmt->get_result();
    if ($repo_result->num_rows == 1) {
      while ($repo_row = $repo_result->fetch_row()) {
        $repo_id = $repo_row[0];
      }
    }
    $repo_stmt->close();
    $mysqli->close();
  }
  return $repo_id;
}

// Print previous and next buttons for search
function print_nav() {
  return '<nav class="page-nav">
    <div class="prev">
      <button onclick="nav_page(\'prev\');">&laquo; Previous page</button>
    </div>
    <div class="jump">
      <p>Page <select name="page" class="page-select"><option value="1">1</option></select> of <span class="total-pages"></span></p>
    </div>
    <div class="next">
      <button onclick="nav_page(\'next\');">Next page &raquo;</button>
    </div>
  </nav>';
}

// Print sort select
function print_sort($query, $sort) {
  $sort_options = array(
    'date' => 'Date Submitted',
    'title' => 'Title'
  );
  ob_start();
  echo '
    <form id="sort-form" action="">
      <label for="sort">Sort by</label>
      <select name="sort" id="sort">';
  if ($query) {
    echo '<option value="score">Relevance</option>';
  }
  foreach ($sort_options as $value => $label) {
    echo '<option value="' . $value . '"';
    if ($value == $sort) {
      echo ' selected="selected"';
    }
    echo '>' . $label . '</option>';
  }
  echo '</select>
    </form>';
  $sort = ob_get_contents();
  ob_end_clean();
  return $sort;
}

// POST ARKs from ranked results to get-brief.xq
function get_brief_records($arks) {
  $session = new AW_Session();
  $query = $session->get_query('get-brief.xq');
  $query->bind('a', implode('|', $arks));
  $brief_result_string = $query->execute();
  $query->close();
  $session->close();
  if ($brief_result_string) {
    return parse_brief_records($brief_result_string);
  }
  else {
    throw new Exception('Could not connect to BaseX server.');
  }
}

// POST ARKs, query, and type from ranked results to get-brief-matches.xq
function get_brief_matches($arks, $filtered_query, $type) {
  $session = new AW_Session();
  $query = $session->get_query('get-brief-matches.xq');
  $query->bind('a', implode('|', $arks));
  $query->bind('q', $filtered_query);
  $query->bind('f', ($type == 'fuzzy' ? 'true' : 'false'));
  $brief_result_string = $query->execute();
  $query->close();
  $session->close();
  if ($brief_result_string) {
    return parse_brief_records($brief_result_string);
  }
  else {
    throw new Exception('Could not connect to BaseX server.');
  }
}

// Parse brief result XML
function parse_brief_records($brief_result_string) {
  $brief_xml = simplexml_load_string($brief_result_string);
  $brief_records = array();
  $all_repos = get_all_repos();
  foreach ($brief_xml->children() as $result) {
    $db = (string) $result['db'];
    $ark = (string) $result['ark'];
    $brief_records[$ark] = array(
      'title' => (string) $result->title,
      'date' => (string) $result->date,
      'repo_info' => $all_repos[$db],
      'abstract' => (string) $result->abstract,
      'matches' => (string) $result->matches
    );
  }
  return $brief_records;
}

// Print brief records from array of ARKs
function print_brief_records($arks, $raw_query, $filtered_query, $type, $include_matches = false) {
  if ($include_matches) {
    $brief_records = get_brief_matches($arks, $filtered_query, $type);
  }
  else {
    $brief_records = get_brief_records($arks);
  }
  ob_start();
  foreach ($arks as $ark) {
    if (isset($brief_records[$ark])) {
      $result = $brief_records[$ark];
      echo '<div class="result">';
      echo '<h4><a href="' . AW_DOMAIN . '/ark:' . $ark;
      if ($query) {echo '?q=' . $raw_query;}
      echo '" target="_blank">' . $result['title'] . '</a></h4>';
      echo '<p class="repo"><span class="label">Repository:</span> <a href="/contact.php#' . $result['repo_info']['mainagencycode'] . '">' . $result['repo_info']['name'] . '</a></p>';
      if ($result['abstract']) {
        echo '<p class="abstract"><span class="label">Abstract:</span> ' . add_links($result['abstract']) . '</p>';
      }
      if ($result['matches']) {
        $matches = explode(',', $result['matches']);
        echo '<p class="matches"><span class="label">Matches:</span> <span class="match">' . implode('</span><span class="match">', $matches) . '</span></p>';
      }
      echo '</div>';
    }
  }
  $results_html = ob_get_contents();
  ob_end_clean();
  return $results_html;
}

// Print RSS feed entries
function print_rss() {
  ob_start();
  $url = AW_DOMAIN . '/rss.php';
  echo '<p class="rss-subscribe"><img src="/layout/images/rss.svg" width="16px" alt="RSS icon" /> <a href="' . $url . '">Subscribe to our RSS feed</a></p>';
  $rss = simplexml_load_file($url);
  foreach ($rss->channel->item as $item) {
    $pubdate = (string) $item->pubDate;
    $date = date('F j, Y g:i a', strtotime($pubdate));
    echo '<div class="rss-item">';
    echo '<p class="rss-date">' . $date . '</p>';
    echo '<p class="rss-title"><a href="' . (string) $item->link . '">' . (string) $item->title . '</a></p>';
    echo '<p class="rss-desc">' . (string) $item->description . '</p>';
    echo '</div>';
  }
  $rss_html = ob_get_contents();
  ob_end_clean();
  return $rss_html;
}

// Check maintenance mode
function check_maintenance_mode() {
  return file_exists(AW_HTML . '/maintenance.html');
}

// Get maintenance file
function get_maintenance_file() {
  return file_get_contents(AW_HTML . '/maintenance.html');
}
?>
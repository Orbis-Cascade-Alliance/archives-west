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
    'geogname'=>'geogname',
    'name'=>'persname|famname|corpname',
    'subject'=>'subject',
    'occupation'=>'occupation',
    'genreform'=>'genreform'
  );
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

// Return opts for POST queries
function get_opts($body) {
  return array(
    'http' => array(
      'method' => 'POST',
      'header' => array(
        'Authorization: Basic ' . base64_encode(BASEX_USER.':'.BASEX_PASS),
        'Content-type: application/x-www-form-urlencoded'
      ),
      'content' => $body
    )
  );
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
function get_brief_records($arks, $type='full') {
  switch ($type) {
    case 'full':
      $xquery = 'get-brief.xq';
    break;
    case 'min':
      $xquery = 'get-brief-min.xq';
    break;
  }
  $body = '<run>
    <variable name="a" value="' . implode('|', $arks) . '" />
    <text>' . $xquery . '</text>
  </run>';
  $opts = get_opts($body);
  $context = stream_context_create($opts);
  if ($brief_result_string = file_get_contents(BASEX_REST, FALSE, $context)) {
    $brief_xml = simplexml_load_string($brief_result_string);
    $brief_records = array();
    $all_repos = get_all_repos();
    foreach ($brief_xml->children() as $result) {
      $db = (string) $result->db;
      $ark = (string) $result->ark;
      $title = (string) $result->title;
      $date = (string) $result->date;
      $repo_info = $all_repos[$db];
      $brief_records[$ark] = array(
        'title' => $title,
        'date' => $date,
        'repo_info' => $repo_info
      );
      if ($type == 'full') {
        $abstract = (string) $result->abstract;
        $brief_records[$ark]['abstract'] = $abstract;
      }
    }
    return $brief_records;
  }
  else {
    throw new Exception('Could not connect to BaseX server.');
  }
}

// Print brief records from array of ARKs
function print_brief_records($arks, $query) {
  $brief_records = get_brief_records($arks, 'full');
  ob_start();
  foreach ($arks as $ark) {
    if (isset($brief_records[$ark])) {
      $result = $brief_records[$ark];
      echo '<div class="result">';
      echo '<h4><a href="' . AW_DOMAIN . '/ark:/' . $ark;
      if ($query) {echo '?q=' . $query;}
      echo '" target="_blank">' . $result['title'] . '</a></h4>';
      echo '<p class="repo"><span class="label">Repository:</span> <a href="/contact.php#' . $result['repo_info']['mainagencycode'] . '">' . $result['repo_info']['name'] . '</a></p>';
      if ($result['abstract']) {
        echo '<p class="abstract"><span class="label">Abstract:</span> ' . add_links($result['abstract']) . '</p>';
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
?>
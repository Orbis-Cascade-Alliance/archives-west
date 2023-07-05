<?php
// Query BaseX with submitted keywords
session_start();
header("Access-Control-Allow-Origin: *");
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');

// Get per_page value from session
if (!isset($_SESSION['per_page'])) {
  $_SESSION['per_page'] = DEFAULT_PER_PAGE;
}

if (!empty($_POST)) {
  $time_start = time();
  // Get submitted search parameters (query, mainagencycode, and facets)
  $query = urldecode(filter_var($_POST['query'], FILTER_SANITIZE_STRING));
  $mainagencycode = filter_var($_POST['mainagencycode'], FILTER_SANITIZE_STRING);
  $facets = array();
  if (isset($_POST['facet']) && !empty($_POST['facet'])) {
    foreach ($_POST['facet'] as $facet) {
      $first_colon = strpos($facet, ':');
      $facet_type = filter_var(substr($facet, 0, $first_colon), FILTER_SANITIZE_STRING);
      $facet_term = filter_var(substr($facet, $first_colon+1), FILTER_SANITIZE_STRING);
      $facets[$facet_type] = urldecode($facet_term);
    }
  }
  $page = filter_var($_POST['page'], FILTER_SANITIZE_NUMBER_INT);
  $sort = filter_var($_POST['sort'], FILTER_SANITIZE_STRING);
  $type = 'fuzzy';
  if (isset($_POST['type']) && !empty($_POST['type'])) {
    $type = filter_var($_POST['type'], FILTER_SANITIZE_STRING);
  }
  
  // If at least one parameter...
  if ($query || $facets || $mainagencycode) {
    
    // If mainagencycode ID submitted, set $repos to one-item array of the repository ID
    if ($mainagencycode) {
      $codes = explode('|', $mainagencycode);
      $repos = array();
      foreach ($codes as $code) {
        if ($repo_id = get_id_from_mainagencycode($code)) {
          $repos[] = $repo_id;
        }
        else {
          die('<p>No repository with the identifier "' .$code . '" exists.</p>');
        }
      }
    }
    // If no mainagencycode ID submitted, set $repos to all repository IDs
    else {
      $repos = array_keys(get_all_repos());
    }
    
    // Construct the AW_Search object
    $time_search = time();
    try {
      $search = new AW_Search($query, $facets, $repos, $sort, $type);
    }
    catch (Exception $e) {
      die('<p>Error communicating with the server for full-text searching.</p>');
      // Mail webmaster
      $mail = new AW_Mail('webmaster@orbiscascade.org', 'Search Exception in Archives West', $e->getMessage());
      $mail->send();
    }
    $time_finished = time();
    // Print the #results div contents (facets, brief records, all-arks for JS)
    //echo '<p>Filtered query: ' . $search->get_filtered_query();
    if ($search->get_result_count() > 0) {
      
      $all_arks = $search->get_results();
      $offset = (integer) ($page-1) * $_SESSION['per_page'];
      $first_arks = array_slice($search->get_results(), $offset, $_SESSION['per_page']);
      
      // Facet toggle button for mobile
      echo '<p id="facets-toggle-wrapper"><button id="facets-toggle" onclick="toggle_facets()" aria-controls="facets" aria-expanded="false">Refine Search</button></p>';
      
      // Start flex row
      echo '<p id="excluded-words">' . $search->print_excluded_words() . '</p>';
      echo '<div class="flex">';
      
      // Facets
      echo '<div id="facets">';
      echo '<h2>Refine Search</h2>';
      echo print_sort($query, $sort);
      echo $search->print_selected_facets();
      echo $search->print_facets();
      echo '</div>';
      
      // Finding aids
      echo '<div id="finding-aids"><h2 class="visuallyhidden">Finding Aids</h2>';
      include(AW_INCLUDES . '/pagination.php');
      echo $search->print_result_count();
      echo print_nav();
      echo '<div id="brief-loading" class="loading"></div>';
      echo '<div id="brief-records">';
      echo print_brief_records($first_arks, $query);
      echo '</div>';
      echo print_nav();
      echo '</div>';
      
      // All result ARKs to store in JS for pagination
      echo '<div id="all-arks">' . implode('|', $all_arks) . '</div>';
      
      // End flex row
      echo '</div><!-- end flex -->';
      $time_printed = time();
      // Print times
      echo '<div style="display:none;">
        <p>Start to search: ' . ($time_search - $time_start) . ' s</p>
        <p>Search complete: ' . ($time_finished - $time_start) . ' s</p>
        <p>Printing complete: ' . ($time_printed - $time_finished) . ' s</p>
      </div>';
    }
    
    // Print no results message
    else {
      echo '<p class="no-results">No results';
      if ($query) {
        echo ' for <span class="search-term">' . $query . '</span>';
      }
      if ($mainagencycode) {
        $repo = new AW_Repo($repos[0]);
        echo ' in <a href="contact.php#' . $repo->get_mainagencycode() . '">' . $repo->get_name() . '</a>';
      }
      if ($facets) {
        $facet_headings = get_facet_headings();
        $facet_strings = array();
        foreach ($facets as $facet_type => $facet_term) {
          $facet_strings[] = $facet_headings[$facet_type] . ' "' . $facet_term . '"';
        }
         echo ' with ' . implode(' and ', $facet_strings);
      }
      echo '.</p>';
      preg_match('/\d/', $query, $digits);
      if ($digits) {
        echo '<p>Try removing any dates or other numbers from your query.</p>';
      }
      echo '<p id="excluded-words">' . $search->print_excluded_words() . '</p>';
    }
  }
}

?>
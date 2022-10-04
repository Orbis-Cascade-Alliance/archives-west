<?php
// AW_Search performs fulltext keyword searches of Archives West

class AW_Search {
  
  public $query; // String keywords submitted
  private $filtered_query; // String
  public $facets; // Array of submitted facets with keys type and values term
  public $repos; // Array of repository IDs to search
  public $sort; // String sort order
  public $type; // String 'fuzzy' or 'exact'
  private $repo; // Object AW_Repo for a single repository search
  private $results; // Array of ARKs
  private $excluded_words; // Array of words excluded from search;
  public $time;
  
  function __construct($query, $facets, $repos, $sort, $type) {
    $this->query = $query;
    $this->filtered_query = $this->filter_stopwords($query);
    $this->facets = $facets;
    $this->repos = $repos;
    $this->type = $type;
    if (count($repos) == 1) {
      try {
        $this->repo = new AW_Repo($repos[0]);
      }
      catch (Exception $e) {
        throw new Exception($e->getMessage());
      }
    }
    if ($sort) {
      $this->sort = $sort;
    }
    else {
      if ($query) {
        $this->sort = 'score';
      }
      else {
        $this->sort = 'date';
      }
    }
    $this->get_results();
  }
  
  // Get the submitted query
  function get_query() {
    return $this->query;
  }
  
  // Get the submitted sort
  function get_sort() {
    return $this->sort;
  }
  
  // Encode query for printing
  function encode_query() {
    $query = $this->query;
    $encoded_query = urlencode($query);
    $to_replace = array('%26%2334%3B', '%26%2339%3B');
    $replacements = array('&#34;', '&#39;');
    return str_replace($to_replace, $replacements, $encoded_query);
  }
  
  // Decode query for searching
  // Removes single quotes and hyphens entirely
  function decode_query() {
    $query = $this->query;
    $to_replace = array('&#34;', '&#39;', '-');
    $replacements = array('"', ' ', ' ');
    return str_replace($to_replace, $replacements, $query);
  }
  
  // Get the filtered version of the query submitted to BaseX
  function get_filtered_query() {
    return $this->filtered_query;
  }
  
  // Remove punctuation from a string
  function strip_chars($string) {
    $stripped = preg_replace('/[^a-z0-9\-\s]+/i', '', $string);
    return preg_replace('/\s+/', ' ', $stripped);
  }
  
  // Filter the query passed to BaseX using the stopwords file
  function filter_stopwords($query) {
    $decoded_query = $this->decode_query($query);
    
    // Remove stopwords
    $filtered_query = $decoded_query;
    if ($fh = fopen(AW_INCLUDES . '/stopwords.txt', 'r')) {
      
      // Separate query into terms
      // Retains phrases in double quotes
      preg_match_all('/"(?:\\\\.|[^\\\\"])*"|\S+/', $decoded_query, $matches);
      $exploded_query = $matches[0];
      
      // Get stopwords from file
      $stopwords = array();
      $excluded_words = array();
      while (!feof($fh)) {
        $stopword = trim(fgets($fh));
        $stopwords[$stopword] = true;
      }
      
      // For each term, remove if stopword
      foreach ($exploded_query as $key => $term) {
        // If whole term is a stopword, exclude
        if (!stristr($term, ' ')) {
          $lowercase_term = strtolower($term);
          if ($lowercase_term && isset($stopwords[$lowercase_term])) {
            unset($exploded_query[$key]);
            $excluded_words[] = $term;
          }
          else {
            $exploded_query[$key] = $this->strip_chars($term);
          }
        }
        // If term is a phrase and contains a stopword, remove it
        else {
          $exploded_term = $this->strip_chars(explode(' ', $term));
          $replaced_term = $term;
          foreach ($exploded_term as $word_key => $word) {
            $lowercase_word = strtolower($word);
            if ($lowercase_word && isset($stopwords[$lowercase_word])) {
              $replaced_term = str_replace($word, '', $replaced_term);
            }
          }
          $exploded_query[$key] = $this->strip_chars($replaced_term);
        }
      }
      
      // Implode with bar separator for tokenization in search-fulltext.xq
      $filtered_query = implode('|', $exploded_query);
      $this->excluded_words = $excluded_words;
      fclose($fh);
    }
    else {
      throw new Exception('Unable to open stopwords file.');
    }
    return $filtered_query;
  }
  
  // Get array of words excluded from query
  function get_excluded_words() {
    return $this->excluded_words;
  }
  
  // Print excluded words message
  function print_excluded_words() {
    if ($excluded_words = $this->get_excluded_words()) {
      return 'The following terms were excluded from the search: <span>' . implode('</span>, <span>', $excluded_words) . '</span>.';
    }
  }
  
  // Get the submitted facets
  function get_facets() {
    return $this->facets;
  }
  
  // Get selected repos
  function get_repos() {
    return $this->repos;
  }
  
  // For single repository searches, get AW_Repo object
  function get_repo() {
    return $this->repo;
  }
  
  // Get fuzzy/exact type
  function get_type() {
    return $this->type;
  }
  
  // Get ARK strings from search results
  function regex_arks($result_string) {
    $result_xml = preg_match_all("/<ark>(80444\/xv[0-9]+)<\/ark>/", $result_string, $ark_matches);
    return $ark_matches[1];
  }
  
  // Get ranked search results as an array
  function get_results() {
    if (!isset($this->results) && $this->get_facet_results() !== false) {
      
      $repos = $this->get_repos();
      $repo_string = implode('|', $repos);
      $facet_results = $this->get_facet_results();
      $ark_string = implode('|', $facet_results);
      $filtered_query = $this->get_filtered_query();
      $fuzzy = 'true';
      if ($this->get_type() == 'exact') {
        $fuzzy = 'false';
      }
      
      // Get results from BaseX
      $time_start = time();
      $results = array();
      $session = new AW_Session();
      if ($filtered_query) {
        $query = $session->get_query('search-fulltext.xq');
        $query->bind('q', $filtered_query);
        $query->bind('d', $repo_string);
        $query->bind('a', $ark_string);
        $query->bind('s', $this->get_sort());
        $query->bind('f', $fuzzy);
      }
      else {
        $query = $session->get_query('search-repo.xq');
        $query->bind('d', $repo_string);
        $query->bind('a', $ark_string);
        $query->bind('s', $this->get_sort());
      }
      $result_string = $query->execute();
      $query->close();
      $session->close();
      if ($result_string) {
        $time_stop = time();
        $this->time = $time_stop - $time_start;
        $results = $this->regex_arks($result_string);
      }
      else {
        throw new Exception('An error occurred in full-text searching.');
      }
      $this->results = $results;
    }
    return $this->results;
  }
  
  // Get ARKs returned for facets
  function get_facet_results() {
    if (!isset($this->facet_results)) {
      $repos = $this->get_repos();
      $repo_ids = implode('|', $repos);
      $results = array();
      if ($facets = $this->get_facets()) {
        $facet_strings = array();
        $to_replace = array('&', '&amp;#39;', '&amp;#34;');
        $replacements = array('&amp;', '\'', '&quot;');
        foreach ($facets as $facet_type => $facet_term) {
          $facet_strings[] = $facet_type . ':' . str_replace($to_replace, $replacements, $facet_term);
        }
        $session = new AW_Session();
        $query = $session->get_query('get-facet-arks.xq');
        $query->bind('d', $repo_ids);
        $query->bind('f', implode('|', $facet_strings));
        $facet_string = $query->execute();
        $query->close();
        $session->close();
        if ($facet_string) {
          if (stristr($facet_string, '<ark>')) {
            $results = $this->regex_arks($facet_string);
          }
          else {
            $results = false;
          }
        }
        else {
          throw new Exception('An error occurred getting facet results.');
        }
      }
      $this->facet_results = $results;
    }
    return $this->facet_results;
  }
  
  // Get count of results
  function get_result_count() {
    $count = 0;
    if ($this->get_results()) {
      $count = count($this->get_results());
    }
    return $count;
  }

  // Print count of results
  function print_result_count() {
    $result_count = $this->get_result_count();
    $result_html = '<p id="result-count-wrapper"><span id="result-count">' . number_format($result_count, 0, '.', ',') . '</span> finding aid';
    if ($result_count == 0 || $result_count > 1) {
      $result_html .= 's';
    }
    $result_html .= '</p>';
    return $result_html;
  }
  
  // Print selected facets
  function print_selected_facets() {
    $facet_headings = get_facet_headings();
    $repos = $this->get_repos();
    $facets_html = '<div id="applied-facets">';
    if ($repo = $this->get_repo()) {
      $facets_html .= '<div class="repo" data-type="repo" data-term="' . $repo->get_mainagencycode() . '">Repository: ' . $repo->get_name() . ' <button class="remove" title="Remove" onclick="remove_facet(this)">X</span></div>';
    }
    if ($facets = $this->get_facets()) {
      foreach ($facets as $facet_type => $facet_term) {
        $facets_html .= '<div class="facet" data-type="' . $facet_type . '" data-term="' . $facet_term . '">' . $facet_headings[$facet_type] . ': ' . $facet_term . ' <button class="remove" title="Remove" onclick="remove_facet(this)">X</span></div>';
      }
    }
    $facets_html .= '</div>';
    return $facets_html;
  }

  // Print facets for ranked results
  function print_facets() {
    // Get ARKs from ranked results
    $results = $this->get_results();
    
    // POST ARKs to facet_terms.xq
    $types = get_facet_types();
    $max_shown = 20;
    $session = new AW_Session();
    $query = $session->get_query('get-facets.xq');
    $query->bind('n', implode('|', array_keys($types)));
    $query->bind('a', implode('|', $results));
    $query->bind('m', $max_shown);
    $facet_result_string = $query->execute();
    $query->close();
    $session->close();
    if ($facet_result_string) {
      $facet_xml = simplexml_load_string($facet_result_string);
      
      // Start output buffer
      ob_start();
      
      // Repository facet
      if (count($this->get_repos()) > 1) {
        $repos = array();
        
        // Get repository information for the ARKs
        if ($mysqli = connect()) {
          $ark_result = $mysqli->query('SELECT repo_id, count(ark) as count
            FROM arks
            WHERE ark IN("' . implode('","', $results) . '")
            GROUP BY repo_id
            ORDER BY count DESC'
          );
          $repos = array();
          while ($ark_row = $ark_result->fetch_assoc()) {
            $repos[$ark_row['repo_id']] = $ark_row['count'];
          }
          
          // Print repository facet
          echo '<h3>Repository</h3>';
          echo '<ul>';
          foreach ($repos as $repo_id => $repo_count) {
            $repo = new AW_Repo($repo_id);
            echo '<li><a href="' . $this->get_link('r=' . $repo->get_mainagencycode()) . '">' . $repo->get_name() . '</a> (' . $repo_count . ')</li>';
          }
          echo '</ul>';
          $mysqli->close();
        }
      }
    }
    else {
      throw new Exception('An error occurred printing facets.');
    }
    
    // Place, Name, Subject, Occupation, and Material Type
    $facet_headings = get_facet_headings();
    $submitted_facets = $this->get_facets();
    foreach ($facet_xml->facet as $facet) {
      $facet_type = (string) $facet['type'];
      if (!isset($submitted_facets[$facet_type])) {
        if (count($facet->term) > 0) {
          $facet_heading = $facet_headings[$facet_type];
          echo '<h3>' . $facet_heading . '</h3>';
          echo '<ul>';
          foreach ($facet->term as $term) {
            echo '<li><a href="' . $this->get_link('facet=' . $facet_type . ':' . urlencode($term['text'])) . '">' . $term['text'] . '</a> (' . $term['count'] . ')</li>';
          }
          echo '</ul>';
        }
      }
    }
    
    // Return contents of output buffer
    $facets_html = ob_get_contents();
    ob_end_clean();
    return $facets_html;
  }
  
  // Get current link with params
  function get_link($new_param) {
    if ($query = $this->get_query()) {
      $params[] = 'q=' . $this->encode_query($query);
    }
    if ($repo = $this->get_repo()) {
      $params[] = 'r=' . $repo->get_mainagencycode();
    }
    if ($facets = $this->get_facets()) {
      $facet_params = '';
      foreach ($facets as $facet_type => $facet_term) {
        $params[] = 'facet=' . $facet_type . ':' . urlencode($facet_term);
      }
    }
    if ($this->get_type() == 'exact') {
      $params[] = 'type=exact';
    }
    $params[] = $new_param;
    return AW_DOMAIN . '/search.php?' . implode('&', $params);
  }
}
?>
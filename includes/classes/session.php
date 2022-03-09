<?php
// AW_Session uses the BaseXClient Session class to run database and index construction commands
// To get results of commands, add print $this->session->info();

// Include client
require_once(BASEX_CLIENT . '/exception.php');
require_once(BASEX_CLIENT . '/session.php');
require_once(BASEX_CLIENT . '/query.php');
use BaseXClient\BaseXException;
use BaseXClient\Session;

class AW_Session {
  
  private $session;
  private $repos;
  
  function __construct() {
    $this->session = new Session("localhost", 1984, BASEX_USER, BASEX_PASS);
  }
  
  // Close session
  function close() {
    $this->session->close();
  }
  
  // Print info
  function print_info() {
    return $this->session->info();
  }
  
  // Get repo IDs
  function get_repos() {
    if (!isset($this->repos)) {
      $this->repos = get_all_repos();
    }
    return $this->repos;
  }
  
  // Build all databases
  function build_dbs() {
    foreach ($this->get_repos() as $repo_id => $repo_info) {
      $this->session->execute('CREATE DB eads' . $repo_id . ' ' . AW_REPOS . '/' . $repo_info['folder'] . '/eads');
    }
  }
  
  // Build a single database
  function build_db($repo_id) {
    $repo = new AW_Repo($repo_id);
    $this->session->execute('CREATE DB eads' . $repo_id . ' ' . AW_REPOS . '/' . $repo->get_folder() . '/eads');
  }
  
  // Drop all databases
  function drop_dbs() {
    foreach ($this->get_repos() as $repo_id => $repo_info) {
      $this->drop_db($repo_id);
    }
  }
  
  // Drop a single database
  function drop_db($repo_id) {
    $this->session->execute('DROP DB eads' . $repo_id);
  }
  
  // Optimize all databases
  function optimize_dbs() {
    foreach ($this->get_repos() as $repo_id => $repo_info) {
      $this->optimize_db($repo_id);
    }
  }
  
  // Optimize a single database
  // ALL rebuilds all index structures
  function optimize_db($repo_id) {
    $this->session->execute('OPEN eads' . $repo_id);
    $this->session->execute('OPTIMIZE ALL');
    $this->session->execute('CLOSE');
  }
  
  // Add a finding aid to a database
  function add_document($repo_id, $file) {
    $repo = new AW_Repo($repo_id);
    $this->session->execute('OPEN eads' . $repo_id);
    $this->session->execute('ADD ' . AW_REPOS . '/' . $repo->get_folder() . '/eads/' . $file);
    $this->session->execute('OPTIMIZE');
    $this->session->execute('CLOSE');
  }
  
  // Delete a finding aid from a database
  function delete_document($repo_id, $file) {
    $this->session->execute('OPEN eads' . $repo_id);
    $this->session->execute('DELETE ' . $file);
    $this->session->execute('OPTIMIZE');
    $this->session->execute('CLOSE');
  }
  
  // Replace a finding aid in a database
  function replace_document($repo_id, $old_file, $new_file) {
    $repo = new AW_Repo($repo_id);
    $this->session->execute('OPEN eads' . $repo_id);
    $this->session->execute('DELETE ' . $old_file);
    $this->session->execute('ADD ' . AW_REPOS . '/' . $repo->get_folder() . '/eads/' . $new_file);
    $this->session->execute('OPTIMIZE');
    $this->session->execute('CLOSE');
  }
  
  // Get stopwords as a string separated by bars
  function get_stopwords() {
    $file = BASEX_INSTALL . '/etc/stopwords.txt';
    $contents = file_get_contents($file, true);
    return preg_replace('/\s/', '|', $contents);
  }
  
  // Delete old text indexes
  function drop_old_text() {
    foreach ($this->get_repos() as $repo_id => $repo_info) {
      $this->session->execute('DROP DB text' . $repo_id);
    }
  }
  
  // Delete a single repository's text index
  function drop_text() {
    $this->session->execute('DROP DB index-text');
  }
  
  // Build text index
  function build_text() {
    $this->session->execute('SET FTINDEX true');
    $this->session->execute('SET FTINCLUDE tokens');
    $this->session->execute('CREATE DB index-text');
    $this->session->execute('CLOSE');
  }
  
  // Populate text index for all databases
  function index_all_text() {
    foreach ($this->get_repos() as $repo_id => $repo_info) {
      $this->index_text($repo_id);
    }
  }
  
  // Populate text index for one database
  function index_text($repo_id) {
    try {
      $input = file_get_contents(AW_HTML . '/xquery/index-text-db.xq');
      $query = $this->session->query($input);
      $query->bind("d", $repo_id);
      $query->bind("s", $this->get_stopwords());
      $query->execute();
      $query->close();
    }
    catch (BaseXException $e) {
      print $e->getMessage();
    }
  }
  
  // Add specific finding aids to the text index
  // Takes string {database ID}:{file}|{database ID 2}:{file 2} etc.
  function add_to_text($files) {
    try {
      $input = file_get_contents(AW_HTML . '/xquery/index-text-files.xq');
      $query = $this->session->query($input);
      $query->bind("f", $files);
      $query->bind("s", $this->get_stopwords());
      $query->execute();
      $query->close();
    }
    catch (BaseXException $e) {
      print $e->getMessage();
    }
  }
  
  // Delete specific finding aids from the text index
  // Takes string of arks separated by bars
  function delete_from_text($arks) {
    try {
      $input = file_get_contents(AW_HTML . '/xquery/delete-text-files.xq');
      $query = $this->session->query($input);
      $query->bind("a", $arks);
      $query->execute();
      $query->close();
    }
    catch (BaseXException $e) {
      print $e->getMessage();
    }
  }
  
  // Delete a whole repository from the text index
  function delete_repo_from_text($repo_id) {
    $this->session->execute('OPEN index-text');
    $this->session->execute('DELETE eads' . $repo_id);
    $this->session->execute('OPTIMIZE');
    $this->session->execute('CLOSE');
  }
  
  // Drop brief record index
  function drop_brief() {
    $this->session->execute('DROP DB index-brief');
  }
  
  // Build brief index
  function build_brief() {
    $this->session->execute('CREATE DB index-brief');
    $this->session->execute('CLOSE');
  }
  
  // Populate brief record index for all databases
  function index_all_brief() {
    foreach ($this->get_repos() as $repo_id => $repo_info) {
      $this->index_brief($repo_id);
    }
  }
  
  // Populate brief record index for one database
  function index_brief($repo_id) {
    try {
      $input = file_get_contents(AW_HTML . '/xquery/index-brief-db.xq');
      $query = $this->session->query($input);
      $query->bind("d", $repo_id);
      $query->execute();
      $query->close();
    } catch (BaseXException $e) {
      print $e->getMessage();
    }
  }
  
  // Add specific finding aids to the brief record index
  // Takes string {database ID}:{file}|{database ID 2}:{file 2} etc.
  function add_to_brief($files) {
    try {
      $input = file_get_contents(AW_HTML . '/xquery/index-brief-files.xq');
      $query = $this->session->query($input);
      $query->bind("f", $files);
      $query->execute();
      $query->close();
    }
    catch (BaseXException $e) {
      print $e->getMessage();
    }
  }
  
  // Delete finding aids from the brief index
  // Takes a string of arks separated by bars
  function delete_from_brief($arks) {
    try {
      $input = file_get_contents(AW_HTML . '/xquery/delete-brief-files.xq');
      $query = $this->session->query($input);
      $query->bind("a", $arks);
      $query->execute();
      $query->close();
    }
    catch (BaseXException $e) {
      print $e->getMessage();
    }
  }
  
  // Delete a whole repository from the brief index
  function delete_repo_from_brief($repo_id) {
    $this->session->execute('OPEN index-brief');
    $this->session->execute('DELETE eads' . $repo_id);
    $this->session->execute('OPTIMIZE');
    $this->session->execute('CLOSE');
  }

  // Drop all facets
  function drop_facets() {
    $types = get_facet_types();
    foreach ($types as $facet_name => $local_names) {
      $this->session->execute('DROP DB facet-' . $facet_name);
    }
  }
  
  // Build all facet indexes for all databases
  function build_facets() {
    $types = get_facet_types();
    foreach ($types as $facet_name => $local_names) {
      $this->session->execute('CREATE DB facet-' . $facet_name);
      $this->session->execute('CLOSE');
    }
  }

  // Populate all facet indexes for all databases
  function index_all_facets() {
    foreach ($this->get_repos() as $repo_id => $repo_info) {
      $this->index_facets($repo_id);
    }
  }
  
  // Populate all facet indexes for one database
  function index_facets($repo_id) {
    $input = file_get_contents(AW_HTML . '/xquery/index-facet-db.xq');
    try {
      $query = $this->session->query($input);
      $query->bind("t", get_facet_string());
      $query->bind("d", $repo_id);
      $query->execute();
      $query->close();
    } catch (BaseXException $e) {
      print $e->getMessage();
    }
  }
  
  // Add/update facet terms for specific finding aids
  // Takes string {database ID}:{file}|{database ID 2}:{file 2} etc.
  function add_to_facets($files) {
    $input = file_get_contents(AW_HTML . '/xquery/index-facet-files.xq');
    $query = $this->session->query($input);
    $query->bind("t", get_facet_string());
    $query->bind("f", $files); 
    $query->execute();
    $query->close();
  }
  
  // Delete finding aids from all facets
  // Takes a string of arks separated by bars
  function delete_from_facets($arks) {
    $types = get_facet_types();
    try {
      $input = file_get_contents(AW_HTML . '/xquery/delete-facet-files.xq');
      $query = $this->session->query($input);
      $query->bind("t", get_facet_string());
      $query->bind("a", $arks);
      $query->execute();
      $query->close();
    }
    catch (BaseXException $e) {
      print $e->getMessage();
    }
  }
  
  // Delete a whole repository from all facets
  function delete_repo_from_facets($repo_id) {
    $types = get_facet_types();
    foreach ($types as $facet_name => $local_names) {
      $this->session->execute('OPEN facet-' . $facet_name);
      $this->session->execute('DELETE eads' . $repo_id);
      $this->session->execute('OPTIMIZE');
      $this->session->execute('CLOSE');
    }
  }
  
  // Copy working indexes to production
  function copy_indexes_to_prod() {
    $index_names = array('index-text', 'index-brief');
    $types = get_facet_types();
    foreach ($types as $facet_name => $local_names) {
      $index_names[] = 'facet-' . $facet_name;
    }
    foreach ($index_names as $index) {
      // Command will work in BaseX 9.7, but need to use db:copy until then
      //$this->session->execute('COPY ' . $index . ' ' . $index . '-prod');
      $this->session->execute('XQUERY db:copy(\'' . $index . '\', \'' . $index . '-prod\')');
    }
  }

}
?>
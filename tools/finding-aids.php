<?php
// Print table of finding aids

// Include definitions
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-functions.php');
session_start();

// Get user from session
if (isset($_SESSION['user'])) {
  $user = $_SESSION['user'];
}
else {
  die();
}

// Get repository ID
$repo_id = 0;
if ($user->is_admin() && isset($_SESSION['repo_id'])) {
  $repo_id = $_SESSION['repo_id'];
}
else {
  $repo_id = $user->get_repo_id();
}

// Get order
$split_order = array('date', 'DESC');
if (isset($_POST['order']) && !empty($_POST['order'])) {
  $order = filter_var($_POST['order'], FILTER_SANITIZE_STRING);
  $split_order = explode(' ', $order);
}
$sort_field = $split_order[0];
$sort_dir = $split_order[1];
  
// Query and print
if ($repo_id != 0) {
  
  $unused = 0;
  
  // Query MySQL and get titles from BaseX
  $arks = array();
  if ($mysqli = connect()) {
    $ark_query = 'SELECT id, ark, date, file, cached FROM arks WHERE repo_id=' . $repo_id . ' AND active=1';
    if ($sort_field == 'ark' || $sort_field == 'file') {
      $ark_query .= ' ORDER BY ' . $order;
    }
    $ark_result = $mysqli->query($ark_query);
    if ($ark_result->num_rows > 0) {
      while ($ark_row = $ark_result->fetch_assoc()) {
        $arks[$ark_row['ark']] = array(
          'file' => $ark_row['file'],
          'cached' => $ark_row['cached'],
          'title' => 'Unknown',
          'date' => $ark_row['date']
        );
        if ($ark_row['file'] == '') {
          $unused++;
        }
      }
    }
    $mysqli->close();
  }
  if ($arks) {
    // Get titles and modification dates from brief records
    $brief_records = get_brief_records(array_keys($arks), 'min');
    foreach ($brief_records as $ark => $brief) {
      $arks[$ark]['title'] = $brief['title'];
      $arks[$ark]['date'] = date('Y-m-d', strtotime($brief['date']));
    }
    if ($sort_field == 'title' || $sort_field == 'date') {
      if ($sort_dir == 'ASC') {
        uasort($arks, function($a, $b) use ($sort_field) {
          $a_title = $a[$sort_field];
          $b_title = $b[$sort_field];
          return strnatcmp($a_title, $b_title);
        });
      }
      else {
        uasort($arks, function($a, $b) use ($sort_field) {
          $a_title = $a[$sort_field];
          $b_title = $b[$sort_field];
          return strnatcmp($b_title, $a_title);
        });
      }
    }
    
    // Print count
    echo '<p><strong>' . number_format((count($arks)-$unused), 0, '', ',') . '</strong> finding aid';
    if (count($arks) != 1) {
      echo 's';
    }
    echo '</p>';
    
    // Unused ARKs
    echo '<p><strong>' . $unused . '</strong> unused ARK';
    if ($unused != 1) {
      echo 's';
    }
    if ($unused > 0) {
      echo ' <button type="button" id="btn-unused">View</button>';
    }
    echo '</p>';
    
    // Print sort select
    echo '<form id="form-sort" action="index.php" method="get">
      <input type="hidden" name="r" value="' . $repo_id . '" />
      <p>
        <label for="sort">Sort by:</label>
        <select name="sort" id="sort">';
    foreach (array('ark'=>'ARK','title'=>'Title','file'=>'File','date'=>'Date') as $sort_value=>$sort_label) {
      echo '<option value="' . $sort_value . '"';
      if ($sort_value == $sort_field) {
        echo ' selected="selected"';
      }
      echo '>' . $sort_label . '</option>';
    }
    echo '</select>
        <select name="dir">';
    foreach (array('ASC'=>'Ascending', 'DESC'=>'Descending') as $dir_value => $dir_label) {
      echo '<option value="' . $dir_value . '"';
      if ($dir_value == $sort_dir) {
        echo ' selected="selected"';
      }
      echo '>' . $dir_label . '</option>';
    }
    echo '</select>
        <input type="submit" value="Update" />
      </p>
    </form>';
    
    // Search
    echo '<form id="form-keyword" onsubmit="return false;">
      <label for="keyword">Keyword:<button type="button" class="help" data-dialog="keyword">?</button> </label>
      <input type="text" id="keyword" name="keyword" />
      <input type="submit" value="Filter Table" />
      <input type="button" id="reset" value="Reset Table" />
    </form>';
    
    // Pagination
    echo '<div class="pagination">
      <div class="prev">
        <button type="button">&laquo; Previous</button>
      </div>
      <div class="num-results"></div>
      <div class="next">
        <button type="button">Next &raquo;</button>
      </div>
    </div>';
    
    // Table
    echo '<table id="finding-aids">
      <thead>
        <tr>
          <th rowspan=2>ARK</th>
          <th rowspan=2>Title</th>
          <th rowspan=2>File</th>
          <th rowspan=2>Date</th>
          <th colspan=2>Actions</th>
        </tr>
        <tr>
          <th>Upload</th>
          <th>Delete</th>
        </tr>
      </thead>
      <tbody>';
    foreach ($arks as $ark => $ark_info) {
      echo '<tr>
        <td class="ark">' . $ark . '</td>
        <td class="title">';
        if ($ark_info['title'] != 'Unknown') {
          if ($ark_info['cached'] == 1) {
            echo '<a href="' . AW_DOMAIN . '/ark:/' . $ark . '" target="_blank">' . $ark_info['title'] . '</a>';
          }
          else {
            echo $ark_info['title'] . ' (In Process)';
          }
        }
        echo '</td>
        <td class="file"><a href="' . AW_DOMAIN . '/ark:/' . $ark . '/xml" target="_blank" title="' . $ark_info['file'] . '">' . mb_strimwidth($ark_info['file'], 0, 30, "...") . '</a></td>
        <td class="date">' . substr($ark_info['date'], 0, 10) . '</td>
        <td class="upload"><a href="' . AW_DOMAIN . '/tools/upload.php?ark=' . $ark . '">' . ($ark_info['file']=='' ? 'Upload' : 'Replace') . '</a></td>
        <td class="delete"><button class="btn-delete" type="button" onclick="confirm_deletion(\'' . $ark . '\', \'' . $ark_info['title'] . '\')">Delete</button></td>
      </tr>';
    }
    echo '</tbody></table>';
  }
  else {
    echo '<p>No finding aids yet!</p>';
  }
}
?>
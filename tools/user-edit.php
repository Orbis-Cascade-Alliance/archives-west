<?php
// Edit an exising user or create a new one

// Get username
$username = '';
if (isset($_GET['u']) && !empty($_GET['u'])) {
  $username = filter_var($_GET['u'], FILTER_SANITIZE_STRING);
}

// Include definitions
$page_title = $username == '' ? 'New User' : 'Edit User';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
include(AW_TOOL_INCLUDES . '/tools-header-end.php');
if ($user->is_admin()) {
  try {
    $user_object = new AW_User($username);
  }
  catch(Exception $e) {
    echo $e->getMessage();
  }

  if (($username != '' && is_object($user_object)) || $username == '') {
    
    // Print confirmation and error messages
    if (isset($_SESSION['user_edit_type']) && !empty($_SESSION['user_edit_type'])) {
      if (isset($_SESSION['user_edit_errors']) && !empty($_SESSION['user_edit_errors'])) {
        echo print_errors($_SESSION['user_edit_errors']);
      }
      else {
        echo '<p class="success">User ' . $username . ' ' . $_SESSION['user_edit_type'] . '!</p>';
      }
      $_SESSION['user_edit_errors'] = array();
      $_SESSION['user_edit_type'] = '';
    }
  ?>
    <form id="form-user" class="table-layout" method="post" action="<?php echo AW_DOMAIN; ?>/tools/user-edit-process.php">
      <input type="hidden" name="user_id" value="<?php echo $username == '' ? 0 : $user_object->get_id(); ?>" />
      <p><label for="username">Username</label><input type="text" name="username" id="username" value="<?php echo $username; ?>" /></p>
      <?php
        if ($username == '') {
          echo '<label for="password">Password</label><input type="text" name="password" id="password" />';
        }
      ?>
      <p>
        <label for="repo_id">Repository</label>
        <select name="repo_id" id="repo_id">
          <option value="0">No Repository</option>
        <?php
          $all_repos = get_all_repos();
          foreach ($all_repos as $repo_id => $repo_info) {
            echo '<option value="' . $repo_id . '"';
            if ($repo_id == $user_object->get_repo_id()) {
              echo ' selected="selected"';
            }
            echo '>' . $repo_info['name'] . '</option>';
          }
        ?>
        </select>
      </p>
      <p>
        <label for="admin">Administrator</label>
        <input name="admin" id="admin" type="checkbox" value="1" <?php if ($user_object->is_admin()) {echo 'checked="checked"';} ?> />
      </p>
      <p><input type="submit" value="<?php echo $username == '' ? 'Create User' : 'Update User' ?>" /></p>
    </form>
  <?php
  }
}
else {
  echo '<p>This tool is for admins only.</p>';
}
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
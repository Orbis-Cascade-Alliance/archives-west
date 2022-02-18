<?php
// Manage user accounts

// Include definitions
$page_title = 'Manage Users';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
?>
<script src="/tools/scripts/user-manager.js"></script>
<?php
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

if ($user->is_admin()) {
  // Get all users
  $all_users = array();
  if ($mysqli = connect()) {
    $user_result = $mysqli->query('SELECT id, username FROM users ORDER BY username ASC');
    while ($user_row = $user_result->fetch_assoc()) {
      $all_users[$user_row['id']] = new AW_User($user_row['username']);
    }
    $mysqli->close();
  }
?>
  <p><a href="<?php echo AW_DOMAIN; ?>/tools/user-edit.php">Create New User</a></p>
<?php
  if (!empty($all_users)) {
    echo '<table id="users">
      <thead>
        <tr><th rowspan=2>Username</th><th rowspan=2>Repository</th><th rowspan=2>Admin?</th><th colspan=3>Actions</th></tr>
        <tr><th><span class="no-break">Edit User</span></th><th><span class="no-break">Reset Password</span></th><th><span class="no-break">Delete User</span></th></tr>
      </thead>
      <tbody>';
    foreach ($all_users as $user_object) {
      $username = $user_object->get_username();
      $user_repo = new AW_Repo($user_object->get_repo_id());
      $is_admin = $user_object->is_admin() ? 'Yes' : 'No';
      echo '<tr><td>' . $username . '</td><td>' . $user_repo->get_name() . '</td><td>' . $is_admin . '</td><td><a href="user-edit.php?u=' . $username . '">Edit User</a></td><td><button class="btn-reset" type="button" onclick="confirm_reset(\'' . $username . '\')">Reset Password</button></td><td><button class="btn-delete" type="button" onclick="confirm_deletion(\'' . $username . '\')">Delete User</button></td></tr>';
    }
    echo '
      </tbody>
    </table>';
  }
  else {
    echo '<p>No users yet!</p>';
  }
  ?>
  <div id="dialog-delete" title="Delete User">
    <p>Are you sure you want to delete <span id="delete-username">this user</span>?</p>
  </div>
  <div id="dialog-reset" title="Reset Password">
    <form id="form-reset" action="user-password-reset.php" method="post">
      <p><label for="new_password">Enter a new password for <span id="reset-username">this user</span>.</label></p>
      <p><input type="text" name="new_password" id="new_password" /></p>
    </form>
  </div>
  <div id="dialog-confirm" title="Success"></div>
  <div id="dialog-error" title="Error"></div>
<?php
}
else {
  echo '<p>This tool is for admins only.</p>';
}
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
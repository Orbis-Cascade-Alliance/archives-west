<?php
// Include definitions
$page_title = 'Sign In';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');

$errors = array();
if (isset($_POST) && !empty($_POST)) {
  $username = '';
  $password = '';
  if (isset($_POST['username']) && !empty($_POST['username'])) {
    $username = filter_var($_POST['username'], FILTER_SANITIZE_STRING);
  }
  else {
    $errors[] = 'Username is required';
  }
  if (isset($_POST['password']) && !empty($_POST['password'])) {
    $password = filter_var($_POST['password'], FILTER_SANITIZE_STRING);
  }
  else {
    $errors[] ='Password is required';
  }
  
  // Check password against hash in users table
  if ($username && $password) {
    try {
      $user = new AW_User($username);
      $redirect = AW_DOMAIN . '/tools/index.php';
      if (isset($_GET['redirect']) || !empty($_GET['redirect'])) {
        $redirect = $_GET['redirect'];
      }
      if ($user->verify($password)) {
        $_SESSION['user'] = $user;
        header('Location: ' . $redirect);
      }
      else {
        $errors[] = 'Password is incorrect.';
      }
    }
    catch (Exception $e) {
      $errors[] = $e->getMessage();
    }
  }
}

// Begin page
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

// Print errors
if ($errors) {
  echo '<ul class="errors">';
  foreach ($errors as $error) {
    echo '<li>' . $error . '</li>';
  }
  echo '</ul>';
}

?>
<form action="<?php echo $_SERVER['REQUEST_URI']; ?>" method="post">
<p>
  <label for="username">Username:</label>
  <input type="text" id="username" name="username" />
</p>
<p>
  <label for="password">Password:</label>
  <input type="password" id="password" name="password" />
</p>
<p><input type="submit" value="Sign In" /></p>
</form>

<?php
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
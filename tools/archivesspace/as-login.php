<?php
// Include definitions
$page_title = 'ArchivesSpace Sign In';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');

$errors = array();

try {
  $repo = new AW_Repo($repo_id);
  $as_host = $repo->get_as_host_api();
  if (!$as_host) {
    $errors[] = 'This repository does not have an ArchivesSpace host defined. Add one in the <a href="' . AW_DOMAIN . '/tools/repository-edit.php">Repository Registry Editor</a>.';
  }
}
catch (Exception $e) {
  $errors[] = $e->getMessage();
}

if ($as_host && isset($_POST) && !empty($_POST)) {
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
  
  // Send authentication request to ArchivesSpace API
  if (empty($errors)) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $as_host . '/users/' . $username . '/login');
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, array('password' => $password));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    $raw_response = curl_exec($ch);
    if ($response = json_decode($raw_response)) {
      if ($session = (string) $response->session) {
        $_SESSION['as_session'] = $session;
        $_SESSION['as_expires'] = strtotime('+1 hour');
        header('Location: harvest.php');
      }
      else {
        $errors[] = 'Access to ArchivesSpace denied.';
      }
    }
    else {
      $errors[] = 'Error logging into ArchivesSpace.';
    }
    curl_close($ch);
  }
}

// Begin page
include(AW_TOOL_INCLUDES . '/tools-header-end.php');
?>
<p style="font-weight:bold;">This page is for testing by the Archives West Standing Group only.</p>
<p>Sign in to your ArchivesSpace account below to use the API to harvest records for Archives West.</p>
<?php
if ($user->is_admin()) {
  // Print repo select form
  include('../repo-form.php');
}

if ($repo_id != 0) {
  // Print errors
  if ($errors) {
    echo '<ul class="errors">';
    foreach ($errors as $error) {
      echo '<li>' . $error . '</li>';
    }
    echo '</ul>';
  }
  if ($as_host) {
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
  }
}
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
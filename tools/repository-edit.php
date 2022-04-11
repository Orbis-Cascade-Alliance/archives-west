<?php
// Edit repository details

// Include definitions
$page_title = 'Edit Repository';
require_once(getenv('AW_HOME') . '/defs.php');
include(AW_INCLUDES . '/server-header.php');
include(AW_TOOL_INCLUDES . '/tools-header.php');
include(AW_TOOL_INCLUDES . '/tools-header-end.php');

function print_field($type, $name, $label, $value) {
  $field = '<p><label for="' . $name . '">' . $label . '</label> ';
  switch ($type) {
    case 'text':
      $field .= '<input type="text" name="' . $name . '" id="' . $name . '" value="' . $value . '" />';
      break;
    case 'textarea':
      $field .= '<textarea name="' . $name . '" id="' . $name . '">' . $value . '</textarea>';
      break;
    case 'address':
      $address_lines = '';
      if ($value != '') {
        $address_lines = implode("\n", $value);
      }
      $field .= '<textarea name="' . $name . '" id="' . $name . '">' . $address_lines . '</textarea>';
      break;
    case 'rights':
      $field .= '<select name="' . $name . '" id="' . $name . '">';
      foreach (array('CC Zero', 'CC Attribution') as $rights) {
        $field .= '<option value="' . $rights . '"';
        if ($rights == $value) {
          $field .= ' selected="selected"';
        }
        $field .= '>' . $rights . '</option>';
      }
      $field .= '</select>';
      break;
    default:
  }
  $field .= '</p>';
  return $field; 
}
?>
<p>Use the form below to edit repository details.</p>
<p>Changes affecting the Contact page will display immediately.</p>
<p>Changes affecting the repository information in the Overview section of finding aids will appear within one day. On the main page, your finding aids will display as "(In Process)" while the webpages are regenerated.</p>
<?php
if ($user->is_admin()) {
  // Print repo select form
  include('repo-form.php');
}
if ($repo_id != 0) {
  // Get repo object
  $repo = new AW_Repo($repo_id);

  // Print error and confirmation messages
  if (isset($_SESSION['repo_edit_attempted']) && $_SESSION['repo_edit_attempted'] == true) {
    if (isset($_SESSION['repo_edit_errors']) && !empty($_SESSION['repo_edit_errors'])) {
      echo print_errors($_SESSION['repo_edit_errors']);
    }
    else {
      echo '<p class="success">Changes saved. See the <a href="' . AW_DOMAIN . '/contact.php#' . $repo->get_mainagencycode() . '" target="_blank">Contact page</a>.</p>';
    }
    $_SESSION['repo_edit_attempted'] = false;
    $_SESSION['repo_edit_errors'] = array();
  }
?>

<form id="form-repo-edit" class="table-layout" method="post" action="<?php echo AW_DOMAIN; ?>/tools/repository-edit-process.php">
  <?php
  echo print_field('text', 'name', 'Repository Name', $repo->get_name());
  echo print_field('text', 'email', 'Email Address', $repo->get_email());
  echo print_field('text', 'url', 'Website URL', $repo->get_url());
  echo print_field('text', 'phone', 'Phone Number', $repo->get_phone());
  echo print_field('text', 'fax', 'Fax Number', $repo->get_fax());
  echo print_field('address', 'address', 'Address', $repo->get_address());
  echo print_field('textarea', 'collection', 'Collection Information', $repo->get_collection_info());
  echo print_field('textarea', 'copy', 'Copy Information', $repo->get_copy_info());
  echo print_field('textarea', 'visit', 'Visitation Information', $repo->get_visit_info());
  echo print_field('rights', 'rights', 'Rights Statement', $repo->get_rights());
  echo print_field('text', 'as_host_api', 'ArchivesSpace Host for API', $repo->get_as_host_api());
  echo print_field('text', 'as_host_oaipmh', 'ArchivesSpace Host for OAI-PMH', $repo->get_as_host_oaipmh());
  ?>
  <p><input type="submit" value="Save Changes" /></p>
</form>

<?php
}
include(AW_TOOL_INCLUDES . '/tools-footer.php');
?>
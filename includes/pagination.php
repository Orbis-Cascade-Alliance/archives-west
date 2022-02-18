<form id="per-page-form" action="">
  <p><label for="per_page">Results per Page</label>
    <select id="per_page" name="per_page">
      <?php
        foreach (array(10, 25, 50) as $per_page) {
          echo '<option value="'. $per_page . '"';
          if ($_SESSION['per_page'] == $per_page) {
            echo ' selected="selected"';
          }
          echo '>' . $per_page . '</option>';
        }
      ?>
    </select>
  </p>
</form>
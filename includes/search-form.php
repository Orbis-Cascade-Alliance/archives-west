<form id="search-form" method="get" action="<?php echo AW_DOMAIN; ?>/search.php">
  <h2 class="visuallyhidden">Search Form</h2>
  <label for="r" class="visuallyhidden">Repository</label>
  <select name="r" id="r">
    <option value="">All Archives West Repositories</option>
    <?php
    $repos = get_all_repos();
    foreach ($repos as $repo) {
      echo '<option value="' . $repo['mainagencycode'] . '">' . $repo['name'] . '</option>';
    }
    ?>
  </select>
  <div class="keywords">
    <label for="q" class="visuallyhidden">Keywords</label>
    <input type="text" name="q" id="q" placeholder="Search finding aids" />
    <input type="submit" value="Search" />
  </div>
  <div class="options">
    <input type="checkbox" name="type" value="exact" id="type-exact" />
    <label for="type-exact">Exact matches only</label>
  </div>
</form>
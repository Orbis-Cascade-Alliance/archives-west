  </head>
  <body>
    <div id="main-content">
      <div id="main-header">
        <div id="title">
          <h1>
          <?php
          echo TOOLS_TITLE;
          if (isset($page_title) && $page_title != '') {
            echo ': ' . $page_title;
          }?>
          </h1>
        </div>
        <?php if (isset($_SESSION['user']) && $_SESSION['user']->get_username()) {?>
        <div id="login">
          Logged in as <span class="username"><?php echo $_SESSION['user']->get_username();?></span> (<a href="<?php echo AW_DOMAIN; ?>/tools/logout.php">Logout</a>)
        </div>
        <?php } ?>
      </div>
      <div id="page-content">
      <?php
      if ($current_page == 'user-edit.php') {
        echo '<p id="back"><a href="' . AW_DOMAIN . '/tools/user-manager.php">&laquo; Back to User Manager</a></p>';
      }
      else if ($current_page != 'index.php' && $current_page != 'login.php') {
        echo '<p id="back"><a href="' . AW_DOMAIN . '/tools">&laquo; Back to Main</a></p>';
      }
      ?>
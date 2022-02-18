$(document).ready(function() {
  $('#menu-toggle').click(function() {
    if ($('#header-menu').is(':visible')) {
      $('#header-menu').hide();
      $(this).attr('aria-expanded', 'false');
    }
    else {
      $('#header-menu').show();
      $(this).attr('aria-expanded', 'true');
    }
  });
});
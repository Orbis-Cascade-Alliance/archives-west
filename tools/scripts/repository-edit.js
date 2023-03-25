$(document).ready(function() {
  $('#dialog-test').dialog({
    autoOpen: false,
    width: 500
  });
  toggle_test_btn();
  $('input#as_host').keyup(toggle_test_btn);
  $('button#as-test').click(test_connection);
});

// Show/hide Test Connection button
function toggle_test_btn() {
  if ($('input#as_host').val() == '') {
    $('button#as-test').hide();
  }
  else {
    $('button#as-test').show();
  }
}

// Test cURL connection to ArchivesSpace
function test_connection() {
  $('#dialog-test').html('<div class="loading"></div>').dialog('open');
  var host = $('input#as_host').val();
  $.get('repository-as-host-check.php', {host: host}, function(response) {
    $('#dialog-test').html(response);
  });
  return false;
}
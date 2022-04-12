$(document).ready(function() {
  // jQuery UI Dialogs
  $('#dialog-error').dialog({
    autoOpen: false,
    width: 500
  });
  
  // Form submission
  $('#form-harvest').submit(function(e) {
    e.preventDefault();
    var as_set = $('#as_set').val();
    var start_date = $('#start_date').val();
    if (validate_date(start_date) === true) {
      $('#form-harvest input[type="submit"]').hide();
      $('#results').html('<div class="loading"></div>');
      $.post('harvest-process.php', {as_set: as_set, start_date:start_date}, function(data) {
        $('#results').html(data);
      });
    }
    else {
      $('#dialog-error').dialog('open');
    }
    return false;
  });
});

function validate_date(start_date) {
  const regex = new RegExp('^\\d{4}-\\d{2}-\\d{2}$');
  return regex.test(start_date);
}
$(document).ready(function() {
  // jQuery UI Dialogs
  $('#dialog-error').dialog({
    autoOpen: false,
    width: 500
  });
  
  // Single resource submission
  $('#form-harvest-single').submit(function(e) {
    e.preventDefault();
    var as_resource = $('#as_resource').val();
    submit_form('single', {as_resource: as_resource});
    return false;
  });
  
  // Set submission
  $('#form-harvest-set').submit(function(e) {
    e.preventDefault();
    var as_set = $('#as_set').val();
    var start_date = $('#start_date').val();
    if (validate_date(start_date) === true) {
      submit_form('set', {as_set: as_set, start_date:start_date});
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

function submit_form(type, data) {
  $('#form-harvest-' + type + ' input[type="submit"]').hide();
  $('#results').html('<div class="loading"></div>');
  $.post('harvest-process-' + type + '.php', data, function(result) {
    $('#results').html(result);
  });
}
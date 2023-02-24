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
    var replace_file = ($('#replace_file').is(":checked") ? 1 : 0);
    submit_form('single', {as_resource: as_resource, replace_file: replace_file});
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
  $('#results').html('<div class="loading"></div>');
  $.post('harvest-process-' + type + '.php', data, function(result) {
    if (result.substr(0, 16) == '<p>Harvest job #') {
      var job_page = $(result).find('a').eq(0).attr('href');
      window.location.assign(job_page);
    }
    else {
      $('#results').html(result);
    }
  });
}
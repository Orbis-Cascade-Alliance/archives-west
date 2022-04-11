$(document).ready(function() {
  $('#form-harvest').submit(function(e) {
    e.preventDefault();
    $('#form-harvest input[type="submit"]').hide();
    $('#results').html('<div class="loading"></div>');
    var as_set = $('#as_set').val();
    var start_date = $('#start_date').val();
    $.post('harvest-process.php', {as_set: as_set, start_date:start_date}, function(data) {
      $('#results').html(data);
    });
    return false;
  });
});
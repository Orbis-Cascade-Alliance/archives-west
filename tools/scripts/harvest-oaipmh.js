$(document).ready(function() {
  $('#form-harvest').submit(function(e) {
    e.preventDefault();
    $('#results').html('<div class="loading"></div>');
    var as_repo_id = $('#as_repo_id').val();
    $.post('/tools/oai-pmh/harvest-process.php', {as_repo_id: as_repo_id}, function(data) {
      $('#results').html(data);
    });
    return false;
  });
});
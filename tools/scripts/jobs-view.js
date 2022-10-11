var job_id;
$(document).ready(function() {
  var params = new URLSearchParams(window.location.search);
  job_id = params.get('j');
  if ($('#progress').length > 0) {
    check_progress();
    var interval = setInterval(check_progress, 5000);
  }
});

function check_progress() {
  $.get('jobs-progress.php', {j: job_id}, function(data) {
    $('#progress').html(data);
    if (data == 'Job complete!') {
      setTimeout(window.location.reload(), 5000);
    }
  });
}
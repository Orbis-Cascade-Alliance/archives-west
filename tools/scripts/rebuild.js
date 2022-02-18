// Globals for all repositories
var repo_ids = [];
var iteration_complete = false;

// Globals for one repository
var step = 1;
const total_steps = 6;

$(document).ready(function() {
  $('#form-rebuild').submit(function(e) {
    e.preventDefault();
    rebuild_dbs();
    return false;
  });
  populate_repo_ids();
});

function populate_repo_ids() {
  $('#repo_id option').each(function() {
    repo_id = $(this).val();
    if (repo_id != '') {
      repo_ids.push(repo_id);
    }
  });
}

function rebuild_process(data, next) {
  $.post('rebuild-process.php', data, function(result) {
    $('#results').prepend(result + "\n---");
    next();
  });
}

function rebuild_dbs() {
  $('#form-rebuild').hide();
  $('#results').html('').show();
  const repo_id = $('#repo_id').val();
  if (repo_id == '') {
    $('#results').append("Dropping all databases...\n");
    rebuild_process(
      {type:'all',step:1},
      function() {
        $('#results').append("Rebuilding databases...\n");
        iterate_dbs();
        var interval = setInterval(
          function() {
            if (iteration_complete) {
              clearInterval(interval);
              $('#results').append("Building brief record index...\n");
              rebuild_process(
                {type:'all',step:3},
                function() {
                  $('#results').append("Building facet indexes...\n");
                  rebuild_process(
                    {type:'all',step:4},
                    function() {
                      $('#results').prepend("Rebuild complete!\n");
                      $('#form-rebuild').show();
                      populate_repo_ids();
                      iteration_complete = false;
                    }
                  );
                }
              );
              return true;
            }
            else {
              return false;
            }
          },
          1000
        );
      }
    );
  }
  else {
    iterate_steps(repo_id);
  }
}

function iterate_dbs() {
  var current_id = repo_ids.shift();
  rebuild_process(
    {type:'all',step:2,repo_id:current_id},
    function() {
      if (repo_ids.length > 0) {
        return iterate_dbs();
      }
      else {
        iteration_complete = true;
        return true;
      }
    }
  );
}

function iterate_steps(repo_id) {
  rebuild_process(
    {type:'repo',step:step,repo_id:repo_id},
    function() {
      if (step < total_steps) {
        step++;
        return iterate_steps(repo_id);
      }
      else {
        $('#results').prepend("Rebuild complete!\n");
        $('#form-rebuild').show();
        step = 1;
      }
    }
  );
}
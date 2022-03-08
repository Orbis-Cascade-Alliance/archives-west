// Globals for all repositories
var repo_ids = [];
var iteration_complete = false;

// Globals for one repository
var step = 1;
const total_steps = 7;

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
    $('#results').prepend("Dropping all databases...\n");
    rebuild_process(
      {type:'all',step:1},
      function() {
        $('#results').prepend("Rebuilding databases...\n");
        iterate_dbs(2);
        var interval = setInterval(
          function() {
            if (iteration_complete) {
              clearInterval(interval);
              iteration_complete = false;
              populate_repo_ids();
              $('#results').prepend("Building text indexes...\n");
              iterate_dbs(3);
              var interval2 = setInterval(
                function() {
                  if (iteration_complete) {
                    clearInterval(interval2);
                    $('#results').prepend("Building brief record index...\n");
                    rebuild_process(
                      {type:'all',step:4},
                      function() {
                        $('#results').prepend("Building facet indexes...\n");
                        rebuild_process(
                          {type:'all',step:5},
                          function() {
                            $('#results').prepend("Copying indexes to production...\n");
                            rebuild_process(
                            {type:'all',step:6},
                            function() {
                              $('#results').prepend("Rebuild complete!\n");
                              $('#form-rebuild').show();
                              iteration_complete = false;
                              populate_repo_ids();
                            })
                          }
                        );
                      }
                    );
                  }
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

function iterate_dbs(step) {
  var current_id = repo_ids.shift();
  rebuild_process(
    {type:'all',step:step,repo_id:current_id},
    function() {
      if (repo_ids.length > 0) {
        return iterate_dbs(step);
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
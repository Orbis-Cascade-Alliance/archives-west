$(document).ready(function() {
  
  // jQuery UI Dialogs
  $('#dialog-keyword').dialog({
    autoOpen: false,
    width: 500
  });
  $('#dialog-delete').dialog({
    autoOpen: false,
    width: 500,
    buttons: [
      {
        text: "Yes",
        click: function() {
          delete_finding_aid($(this).data('ark'));
          $(this).dialog('close');
        }
      },
      {
        text: "Cancel",
        click: function() {
          $(this).dialog('close');
        }
      }
    ]
  });
  $('#dialog-error').dialog({
    autoOpen: false,
    width: 500
  });
  $('#dialog-history').dialog({
    autoOpen: false,
    width: 500
  });
  
  // Finding aids table
  if ($('#results').data('tab') == 'f') {
    load_finding_aids();
  }
  
  // Jobs table
  else if ($('#results').data('tab') == 'j') {
    load_jobs();
  }
});

// Apply pagination handlers
function apply_pagination() {
  $('#results table tbody tr').addClass('show');    
  $('#results .prev').click(function() {
    change_page('prev');
  });
  $('#results .next').click(function() {
    change_page('next');
  });
  change_page();
}

// Load finding aids
function load_finding_aids() {
  var order = $('#results').data('order');
  $.post('finding-aids.php', {order: order}, function(data) {
    
    // Print table
    $('#results').html(data);
    
    // Attach handlers
    $('#btn-unused').click(function() {
      filter_table_unused();
    });
    $('#form-keyword').submit(function() {
      filter_table($('#keyword').val().toLowerCase());
      return false;
    });
    $('.help').click(function() {
      $('#dialog-keyword').dialog('open');
    });
    $('#reset').click(function() {
      $('#keyword').val('');
      filter_table('');
    });
    
    // Apply pagination
    apply_pagination();
    
  });
}

// Change rows displayed in finding aids table
function change_page(type) {
  var per_page = 10;
  var total_rows = $('#results table tbody tr.show').length;
  var first_row = $('#results table tbody tr:visible').first().index('#results table tbody tr.show');
  switch(type) {
    case 'prev':
      var offset = first_row - per_page;
    break;
    case 'next':
      var offset = first_row + per_page;
    break;
    default:
      var offset = 0;
    break;
  }
  
  // Hide all rows and show rows within range
  var end = offset + per_page;
  if (end > total_rows) {
    end = total_rows;
  }
  $('#results table tbody tr').hide().filter('.show').slice(offset, end).show();
  
  // Previous button
  if (offset > 0) {
    $('#results .prev button').show();
  }
  else {
    $('#results .prev button').hide();
  }
  
  // Next button
  if ((offset + per_page) < total_rows) {
    $('#results .next button').show();
  }
  else {
    $('#results .next button').hide();
  }
  
  // Number of results displayed
  $('.num-results').html('Displaying ' + (offset+1) + '&ndash;' + end + ' of ' + total_rows);
  
  // Recolor rows
  $('#finding-aids tbody tr').removeClass('even').filter(':visible:even').addClass('even');
  
}

// Filter finding aids table to show unused ARKs
function filter_table_unused() {
  $('#finding-aids tbody tr').removeClass('show').filter(function(index, el) {
    if ($(el).children('.file').eq(0).text() == '') {
      return true;
    }
    else {
      return false;
    }
  }).addClass('show');
  change_page();
}

// Filter finding aids table by keyword
function filter_table(keyword) {
  if (keyword == '') {
    $('#finding-aids tbody tr').addClass('show');
  }
  else {
    $('#finding-aids tbody tr').removeClass('show').filter(function(index, el) {
      var has_keyword = false;
      $(el).children('.title, .ark, .file').each(function() {
        var child_text = $(this).text().toLowerCase();
        if ($(this).hasClass('file')) {
          child_text = $(this).children('a').attr('title').toLowerCase();
        }
        if (child_text.indexOf(keyword) > -1) {
          has_keyword = true;
        }
      });
      return has_keyword;
    }).addClass('show');
  }
  change_page();
}

// Confirm deletion
function confirm_deletion(ark, title) {
  $('#delete-title').text(ark + ': ' + title);
  $('#dialog-delete').data('ark', ark).dialog('open');
}

// Delete finding aid
function delete_finding_aid(ark) {
  $('#results').html('<div class="loading"></div>');
  $.post('delete-process.php', {ark: ark}, function(data) {
    if (data == '') {
      $('#results').html('Finding aid ' + ark + ' was deleted. Reloading table...');
      load_finding_aids();
    }
    else {
      $('#dialog-error').find('span.ark').text(ark).parents('#dialog-error').dialog('open');
      load_finding_aids();
    }
  });
}

// Load jobs
function load_jobs() {
  $.post('jobs.php', function(data) {
    // Print table
    $('#results').html(data);
    
    // Apply pagination
    apply_pagination();
  });
}

// View history of a finding aid
function view_history(el) {
  var ark = $(el).parents('.date').siblings('.ark').text();
  var title = $(el).parents('.date').siblings('.title').text();
  if (title != '') {
    $('#dialog-history').dialog('option', 'title', 'History of ' + title);
  }
  else {
    $('#dialog-history').dialog('option', 'title', 'History');
  }
  $('#dialog-history').html('<p>Loading...</p>').dialog('open');
  $.post('finding-aids-history.php', {ark: ark}, function(result) {
      $('#dialog-history').html(result);
  });
}

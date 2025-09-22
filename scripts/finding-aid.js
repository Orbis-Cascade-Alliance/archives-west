$(document).ready(function() {
  
  // Alerts
  var ark = get_ark();
  if (ark !== false) {
    $.get('/alert.php', {type: 'finding_aid', ark: ark}, function(result) {
      $('#main-content').prepend(result);
    });
  }
  
  // Style return to top links
  $('a[title="Return to Top"]').addClass('backtotop');
  
  // Handle behavior of Table of Contents depending on window width
  toc_structure();
  $(window).resize(function() {
    toc_structure();
  });
  
  // Attach handler to toggle buttons
  $('button.glyphicon')
    .each(function() {
      var content_id = $(this).attr('aria-controls');
      if ($(this).hasClass('glyphicon-triangle-bottom')) {
        $('#' + content_id).show();
      }
      else {
        $('#' + content_id).hide();
      }
      $(this).attr('aria-label', $(this).attr('title'));
    })
    .click(function(e) {
      e.preventDefault();
      toggle_section(this);
    });
    
  // Add links to controlaccess headings
  $('#caID ul.ca_list').each(function() {
    var facet;
    if ($(this).prev('h3').length > 0) {
      var heading_el = $(this).prev('h3');
    }
    else if ($(this).prev('h4').length > 0) {
      var heading_el = $(this).prev('h4');
    }
    var heading = heading_el.text().trim();
    if (heading == 'Subject Terms') {
      facet = 'subject';
    }
    else if (heading == 'Geographical Names') {
      facet = 'geogname';
    }
    else if (heading == 'Form or Genre Terms') {
      facet = 'genreform';
    }
    else if (heading == 'Personal Names' || heading == 'Family Names' || heading == 'Corporate Names') {
      facet = 'name';
    }
    else if (heading == 'Occupations') {
      facet = 'occupation';
    }
    if (typeof(facet) != 'undefined') {
      $(this).children('li').each(function() {
        var facet_term = $(this).text().replace(/\s+/g,' ').trim();
        if (facet == 'name') {
          facet_term = facet_term.replace(/^(.+)\s\([a-z]+\)$/, "$1");
        }
        $(this).wrapInner('<a href="/search.php?facet=' + facet + ':' + encodeURIComponent(facet_term) + '"></a>');
      });
    }
    
  });
    
  // Highlight keyword matches
  // Uses the mark.js library at https://markjs.io/
  var urlParams = new URLSearchParams(window.location.search);
  if (urlParams.get('q') != null) {
    var keyword = urlParams.get('q').replace(/[^a-zA-Z0-9\s]/g, "");
    if (keyword != null) {
      $('#docBody').mark(keyword, {
        "ignorePunctuation": ":;.,-–—‒_(){}[]!'\"+=".split("")
      });
    }
  }
  
  // Dialog for QR codes
  $('#dialog-qr').dialog({
    autoOpen: false,
    width: 300
  });
  $('#btn-qr').click(function(e) {
    e.preventDefault();
    $('#dialog-qr').dialog('open').html('<img src="' + $(this).attr('href') + '" alt="QR Code" />');
    return false;
  });
  
  // Dialog for item actions
  var window_width = $(window).width();
  var window_height = $(window).height();
  var max_width = window_width < 600 ? window_width * 0.85 : 600;
  var max_height = window_height * 0.9;
  $('#dialog-actions').dialog({
    autoOpen: false,
    width: max_width,
    height: max_height,
    title: "Citation Information",
    draggable: false
  });
  $('.btn-citation').click(handle_citation);
  
  // Add classes for DSC display as list or table
  dsc_classes();
  
  // Add DSC toggle button
  $('#dscdiv-content').prepend('<p><label for="dsc-toggle"><span class="switch"><input type="checkbox" id="dsc-toggle" aria-controls="dscul" aria-checked="false"><span class="slider round"></span></span> <span class="text">Enable table view</span></label></p>');
  $('#dsc-toggle').click(dsc_toggle);
  
});

// Get ARK from URL
function get_ark() {
  var ark = window.location.href.match(/80444\/xv[0-9]{5,6}/);
  if (ark.length == 1) {
    return ark[0];
  }
  return false;
}

// Toggle content with glyphicons
function toggle_section(glyphicon) {
  var content_id = $(glyphicon).attr('aria-controls');
  var title = $(glyphicon).attr('title');
  title = title.substring(title.indexOf(' ') + 1);
  if ($('#' + content_id).is(':visible')) {
    $('#' + content_id).hide();
    $(glyphicon).removeClass('glyphicon-triangle-bottom').addClass('glyphicon-triangle-right').attr('aria-expanded', 'false').attr('title', 'Open ' + title);
  }
  else {
    $('#' + content_id).show();
    $(glyphicon).removeClass('glyphicon-triangle-right').addClass('glyphicon-triangle-bottom').attr('aria-expanded', 'true').attr('title', 'Close ' + title);
  }
}

// Set height and behavior of Table of Contents
function toc_structure() { 
  if ($(window).outerWidth() >= 1200) {
    $('#toc').css('max-height', $(window).height());
    $('#toc-toggle').hide();
    $('#toc-ul').show();
  }
  else {
    $('#toc').css('max-height', 'auto');
    $('#toc-toggle').removeClass('glyphicon-triangle-bottom').addClass('glyphicon-triangle-right').attr('aria-expanded', 'false').attr('title', 'Open').show();
    $('#toc-ul').hide();
  }
}

// Print window
function print_finding_aid() {
  window.print();
}

// Add classes to mark uls for table view
// and alternate background colors in list view
function dsc_classes() {
  var prev_li, comparison, label_row, desc, cont, date;
  $('#dscdiv-content li').each(function() {
    prev_li = $(this).prev('li');
    comparison = compare_rows(prev_li, this);
    desc = $(this).children('.c0x_description').length;
    cont = $(this).children('.c0x_container').length;
    date = $(this).children('.c0x_date').length;

    // Alternate background colors
    if ($(this).parents('ul').length%2 == 0) {
      $(this).addClass('gray');
    }
    else {
      $(this).addClass('white');
    }
    
    // If the current item the first of a series, or its previous sibling was a series,
    // or if the containers have changed, mark for a new table
    if ((desc || cont || date) && ($(prev_li).length == 0 || $(prev_li).has('ul').length > 0 || comparison === false)) {
     $(this).addClass('dsc_table');
    }
    
  });
}

// Compare the container types between sequential list items
function compare_rows(prev_li, current_li) {
  var prev_labels = $(prev_li).children('div:not(".c0x_date")').find('.c0x_label');
  var current_labels = $(current_li).children('div:not(".c0x_date")').find('.c0x_label');
  
  // Check if this is the first item in a list
  if ($(prev_labels).length != 0) {
    // Compare text of labels
    for (var c = 0; c < $(prev_labels).length; c++) {
      if (typeof $(current_labels).eq(c)[0] != 'undefined') {
        if ($(prev_labels).eq(c)[0].textContent.trim() != $(current_labels).eq(c)[0].textContent.trim()) {
          return false;
        }
      }
      else {
        return false;
      }
    }
    // If all labels except for dates are the same, don't mark for new table
    return true;
  }
  else {
    return false;
  }
}

// Toggle between views
function dsc_toggle() {
  var type;
  if ($('#dscul').hasClass('display_table')) {
    type = 'list';
    $('#dsc-toggle').attr('aria-checked','false');
  }
  else {
    type = 'table';
    $('#dsc-toggle').attr('aria-checked','true');
  }
  dsc_view(type);
  gtag('event', 'toggle_view', {
    'type': type
  });
}

// Convert list to table or vice versa
function dsc_view(type) {
  var desc, cont, date;
  if (type == 'table') {
    $('#dsc-toggle > span.type').text('list');
    var table, row, has_dates;
    
    // Apply view-specific CSS
    $('#dscul').addClass('display_table');
    
    // Wrap list items to display in each table
    $('#dscdiv-content li.dsc_table').each(function() {
      $(this).nextUntil('li.dsc_table').addBack().wrapAll('<div class="c0x_table">');
    });
    
    // For each wrapper, copy contents into a table element and replace
    $('#dscdiv-content .c0x_table').each(function() {
      if ($(this).children('li').children('.c0x_date').length > 0) {
        has_dates = true;
      }
      else {
        has_dates = false;
      }
      table = '<table class="dsc_table">';
      
      // Headers
      table += '<thead>';
      $(this).children('li').eq(0).children('.c0x_containers').children('.c0x_container').each(function() {
        table += '<th>' + $(this).children('.c0x_label').text() + '</th>';
      });
      if ($(this).children('li').children('.c0x_description').length > 0) {
        table += '<th>Description</th>';
      }
      if (has_dates == true) {
        table += '<th>Dates</th>';
      }
      table += '</thead>';
      
      // Body
      table += '<tbody>';
      $(this).children('li').each(function() {
        desc = $(this).children('.c0x_description').length;
        cont = $(this).children('.c0x_containers').length;
        date = $(this).children('.c0x_date').length;
        if (desc || cont || date) {
          row = '<tr class="' + $(this).attr('class') + '"';
          if ($(this).attr('id') != '' && $(this).attr('id') != 'undefined') {
            row += ' id="' + $(this).attr('id') + '"';
          }
          row += '>';
          // Containers
          if (cont > 0) {
            $(this).children('.c0x_containers').children('.c0x_container').each(function() {
              row += '<td class="c0x_container">' + $(this).html() + '</td>';
            });
          }
          // Description
          if (desc > 0) {
            row += '<td class="c0x_description">';
            row += $(this).children('.c0x_description').eq(0).html();
            row += '<div class="dsc-footer">' + $(this).children('.dsc-footer').eq(0).html() + '</div>';
            row += '</td>';
          }
          // Dates
          if (has_dates == true) {
            row += '<td class="c0x_date">';
            if (date > 0) {
              row += $(this).children('.c0x_date').eq(0).html();
            }
            row += '</td>';
          }
          row += '</tr>';
          table += row;
        }
        if ($(this).find('.c0x_table').length == 0) {
          $(this).remove();
        }
      });
      table += '</tbody></table>';
 
      // Replace wrapper div with a list item
      $(this).before('<li>' + table + '</li>').children('li').unwrap();
    }).remove();
    
  }
  else {
    $('#dsc-toggle > span.type').text('table');
    
    // Apply view-specific CSS
    $('#dscul').removeClass('display_table');
    
    // Replace tables with original list items
    var parent_li;
    $('.dsc_table').each(function() {
      parent_li = $(this).parent('li');
      $(this).children('tbody').children('tr').each(function() {
        desc = $(this).children('.c0x_description').length;
        cont = $(this).children('.c0x_container').length;
        date = $(this).children('.c0x_date').length;
        var footer = $(this).children('.c0x_description').children('.dsc-footer').eq(0).html();
        $(this).children('.c0x_description').children('.dsc-footer').remove();
        new_li = '<li class="' + $(this).attr('class') + '"';
        if ($(this).attr('id') != '' && $(this).attr('id') != 'undefined') {
          new_li += ' id="' + $(this).attr('id') + '"';
        }
        new_li += '>';
        if (desc > 0) {
          new_li += '<div class="c0x_description">' + $(this).children('.c0x_description').eq(0).html() + '</div>';
        }
        if (date > 0) {
          new_li += '<div class="c0x_date">' + $(this).children('.c0x_date').eq(0).html() + '</div>';
        }
        if (cont > 0) {
          new_li += '<div class="c0x_containers"><span class="c0x_label">Container: </span>';
          $(this).children('.c0x_container').each(function() {
            new_li += '<span class="c0x_container">' + $(this).html() + '</span>';
            if ($(this).index() != $(this).siblings('.c0x_container').length ) {
              new_li += ', ';
            }
          });
          new_li += '</div>';
        }
        new_li += '<div class="dsc-footer">' + footer + '</div>';
        new_li += '</li>';
        $(parent_li).before(new_li);
        $('.btn-citation').click(handle_citation);
      });
    }).parent('li').remove();
  }
}

/* Record actions */

function handle_citation(e) {
  e.preventDefault();
  show_citation($(this).parent('div').parent('div').parent('li'));
  return false;
}

function show_citation(item) {
  $('#dialog-actions').dialog('open').html('<div class="loading"></div>');
  $.get('/citation.php', {
    ark: get_ark()
  }, function (result) {
    json = JSON.parse(result);
    var html = '<dl class="citation">';
    if ($(item).children('.c0x_description').length > 0) {
      html += '<dt>Item Description</dt><dd>' + item_description(item) + '</dd>';
    }
    var hierarchy = item_hierarchy(item);
    if (hierarchy.length > 0) {
      html += '<dt>Item Location</dt><dd>' + hierarchy.reverse().join(', ') + '</dd>';
    }
    html += '<dt>Dates</dt><dd>' + item_dates(item) + '</dd>';
    if (json.title != '') {
      html += '<dt>Collection</dt><dd>' + json.title + '</dd>';
    }
    if (json.contributors != '') {
      html += '<dt>Contributors</dt><dd>' + json.contributors + '</dd>';
    }
    html += '<dt>Repository</dt><dd>' + json.repository + '</dd>';
    html += '<dt>Repository Location</dt><dd>' + json.location + '</dd>';
    html += '<dt>URL</dt><dd>' + json.url + '</dd>';
    html += '</dl>';
    $('#dialog-actions').html(html);
  });
  
}

function item_hierarchy(item) {
  var tree = new Array;
  // Clone item containers
  $(item).children('.c0x_containers').children('.c0x_container').each(function() {
    tree.unshift($(this).html());
  });
  // For each list item, add the heading text to an array
  var heading;
  $(item).parents('li').each(function() {
    heading = $(this).children('h3,h4,h5,h6').eq(0).text();
    if (typeof heading != undefined && heading.trim() != '') {
      tree.push(heading.trim());
    }
  });
  return tree;
}

function item_description(item) {
  return '<p>' + $(item).children('.c0x_description').clone().children(':not("a")').remove().end().text() + '</p>';
}

function item_dates(item) {
  if ($(item).children('.c0x_date').length > 0) {
    return $(item).children('.c0x_date').eq(0).clone().children().remove().end().text();
  }
  else {
    return 'Unknown';
  }
}
$(document).ready(function() {
  
  // Alerts
  var ark = window.location.href.match(/80444\/xv[0-9]{5,6}/);
  if (ark.length == 1) {
    $.get('/alert.php', {type: 'finding_aid', ark: ark[0]}, function(result) {
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
    })
    .click(function(e) {
      e.preventDefault();
      toggle_section(this);
    });
    
  // Add links to controlaccess headings
  $('#caID ul.ca_list').each(function() {
    var facet;
    if ($(this).prev('h4').length > 0) {
      var heading_el = $(this).prev('h4');
    }
    else if ($(this).prev('h5').length > 0) {
      var heading_el = $(this).prev('h5');
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
  
  // Add classes for DSC display as list or table
  dsc_classes();
  
});

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
  var prev_labels = $(prev_li).children('div').children('.c0x_label');
  var current_labels = $(current_li).children('div').children('.c0x_label');
  var current_dates = $(current_li).children('.c0x_date').length;
  
  // Check if this is the first item in a list
  if ($(prev_labels).length != 0) {
    // If different lengths, check if the difference is a missing date
    if ($(prev_labels).length != $(current_labels).length) {
      if ($(current_labels).length != $(prev_li).children('div:not(.c0x_date)').length && $(current_li).children('div:not(.c0x_date)').length != $(prev_labels).length) {
        return false;
      }
    }
    // Compare text of labels
    for (var c = 0; c < $(prev_labels).length; c++) {
      if (typeof $(current_labels).eq(c)[0] != 'undefined') {
        if ($(prev_labels).eq(c)[0].textContent.trim() != $(current_labels).eq(c)[0].textContent.trim()) {
          return false;
        }
      }
    }
    // If all labels except for missing dates are the same, don't add row
    return true;
  }
  else {
    return false;
  }
}

// Toggle between views
function dsc_view(type) {
  var desc, cont, date;
  if (type == 'table') {
    var table, row, has_dates;
    
    // Apply view-specific CSS
    $('#dscdiv-content > ul').eq(0).addClass('display_table');
    
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
      $(this).children('li').eq(0).children('.c0x_container').each(function() {
        table += '<th>' + $(this).children('.c0x_label').text() + '</th>';
      });
      table += '<th>Description</th>';
      if (has_dates == true) {
        table += '<th>Dates</th>';
      }
      table += '</thead>';
      
      // Body
      table += '<tbody>';
      $(this).children('li').each(function() {
        desc = $(this).children('.c0x_description').length;
        cont = $(this).children('.c0x_container').length;
        date = $(this).children('.c0x_date').length;
        if (desc || cont || date) {
          row = '<tr>';
          // Containers
          if (cont > 0) {
            $(this).children('.c0x_container').each(function() {
              row += '<td class="c0x_container">' + $(this).html() + '</td>';
            });
          }
          // Description
          if (desc > 0) {
            row += '<td class="c0x_description">' + $(this).children('.c0x_description').eq(0).html() + '</td>';
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
      });
      table += '</tbody></table>';
 
      // Replace wrapper div with a list item
      $(this).before('<li>' + table + '</li>').remove();
    });
  }
  else {
    // Apply view-specific CSS
    $('#dscdiv-content ul:first-child').removeClass('display_table');
    
    // Replace tables with original list items
    var parent_ul, parent_li;
    $('.dsc_table').each(function() {
      parent_ul = $(this).parents('ul').eq(0);
      $(this).children('tbody').children('tr').each(function() {
        desc = $(this).children('.c0x_description').length;
        cont = $(this).children('.c0x_container').length;
        date = $(this).children('.c0x_date').length;
        if ($(this).parents('ul').length%2 == 0) {
          parent_li = '<li class="gray">';
        }
        else {
          parent_li = '<li class="white">';
        }
        if (desc > 0) {
          parent_li += '<div class="c0x_description">' + $(this).children('.c0x_description').eq(0).html() + '</div>';
        }
        if (date > 0) {
          parent_li += '<div class="c0x_date">' + $(this).children('.c0x_date').eq(0).html() + '</div>';
        }
        if (cont > 0) {
          $(this).children('.c0x_container').each(function() {
            parent_li += '<div class="c0x_container">' + $(this).html() + '</div>';
          });
        }
        parent_li += '</li>';
        $(parent_ul).append(parent_li);
      });
    }).parent('li').remove();
  }
}
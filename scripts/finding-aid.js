$(document).ready(function() {
  
  // Handle behavior of Table of Contents depending on window width
  toc_structure();
  table_structure();
  $(window).resize(function() {
    toc_structure();
    table_structure();
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
  
});

// Toggle content with glyphicons
function toggle_section(glyphicon) {
  var content_id = $(glyphicon).attr('aria-controls');
  if ($('#' + content_id).is(':visible')) {
    $('#' + content_id).hide();
    $(glyphicon).removeClass('glyphicon-triangle-bottom').addClass('glyphicon-triangle-right').attr('aria-expanded', 'false').attr('title', 'Open');
  }
  else {
    $('#' + content_id).show();
    $(glyphicon).removeClass('glyphicon-triangle-right').addClass('glyphicon-triangle-bottom').attr('aria-expanded', 'true').attr('title', 'Close');
  }
}

// Set height and behavior of Table of Contents
function toc_structure() { 
  if ($(window).outerWidth() >= 1200) {
    $('#toc').css('max-height', $(window).height());
    $('#toc-toggle').remove();
    $('#toc > ul').show();
  }
  else {
    $('#toc').css('max-height', 'auto');
    if ($('#toc-toggle').length == 0) {
      $('#toc h2').append('<button type="button" id="toc-toggle" class="glyphicon glyphicon-triangle-right" aria-controls="toc-ul" aria-expanded="false" onclick="toggle_section(this);" title="Open"></button>');
      $('#toc > ul').attr('id', 'toc-ul');
    }
  }
}

// Mobile tables
function table_structure() {
  if ($(window).outerWidth() > 760) {
    $('table thead, table tbody tr').show();
    $('table td').css({
      'display': 'table-cell',
      'border-top': '1px solid #ddd',
      'padding': '.5rem'
    });
    $('span.table-label').remove();
  }
  else {
    $('table').each(function() {
      $(this).find('thead').hide();
      $(this).find('td').css({
        'display': 'block',
        'border-top': 'none',
        'padding': '.5rem 0'
      });
      var container_labels = [];
      $(this).find('tbody tr').each(function() {
        if ($(this).find('td span.containerLabel').length > 0) {
          container_labels = [];
          $(this).children('td').each(function() {
            if ($(this).children('span.containerLabel').length > 0) {
              container_labels.push($(this).children('span.containerLabel').text());
            }
            else {
              container_labels.push('');
            }
          });
          $(this).hide();
        }
        else {
          var i = 0;
          $(this).children('td').each(function() {
            if (typeof(container_labels[i]) != 'undefined' && container_labels[i] != '' && $(this).text() != '' && $(this).children('.c02').length == 0 && $(this).children('.table-label').length == 0 && $(this).text().substring(0, container_labels[i].length) != container_labels[i]) {
              $(this).prepend('<span class="table-label">' + container_labels[i] + ':</span> ');
            }
            if ($(this).is(':last-child')) {
              $(this).css('border-bottom', '1px solid #ddd');
            }
            i++;
          });
        }
      });
    });
  }
}

// Print window
function print_finding_aid() {
  window.print();
}
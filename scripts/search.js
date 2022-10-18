var query;
var filtered_query;
var facets;
var mainagencycode;
var sort;
var type;
var arks = [];
var offset = 0;
var per_page;
var scroll_to;

$(document).ready(function() {
  // Perform search from parameters passed in URL
  var urlParams = new URLSearchParams(window.location.search);
  query = urlParams.get('q');
  facets = urlParams.getAll('facet');
  mainagencycode = urlParams.get('r');
  sort = urlParams.get('s');
  if (query || facets || mainagencycode) {
    if (query) {
      $('#q').val(query);
    }
    if (mainagencycode) {
      $('#r option[value="' + mainagencycode + '"]').prop('selected', true);
    }
    page = urlParams.get('p');
    if (page == null || page == '') {
      page = 1;
    }
    type = urlParams.get('type');
    if (type == 'exact') {
      $('#type-exact').prop('checked','true');
    }
    search(page);
  }
  else {
    $('#results').html('<p>Enter a keyword phrase or repository in the form above to search for finding aids.</p>');
  }
});

// Perform an initial search by query, repository mainagencycode ID, and/or facets
function search(page) {
  var start = performance.now();
  $('#results').html('<div class="loading"></div>');
  $.ajax({
    url: "search-query.php",
    method: "post",
    data: {query:query,facet:facets,mainagencycode:mainagencycode,page:page,sort:sort,type:type},
    success: function(results) {
      // Log response time
      var end = performance.now();
      console.log('Response time: ' + (end-start)/1000 + ' seconds');
      
      // Store all arks globally
      if ($(results).find('#all-arks').length > 0) {
        arks = $(results).find('#all-arks').text().split('|');
        
        // Display results
        $('#results').html(results).find('#all-arks').remove();
        
        // Get finding aids offset for scrolling on new pages
        scroll_to = $('#results').find('#finding-aids').offset().top;
      }
      else {
        $('#results').html(results);
      }
      
      // Store filtered query globally
      if ($(results).find('#filtered-query').length > 0) {
        filtered_query = $(results).find('#filtered-query').text();
        $(results).find('#filtered-query').remove();
      }
      
    }
  }).done(function() {
    if (arks.length > 0) {
      // Limit facets to 5 items each
      $('#facets ul').each(function() {
        $(this).children('li:gt(4)').hide();
        if ($(this).children('li:not(:visible)').length > 0) {
          $(this).after('<button onclick="expand_facets(this);">Show more</button>');
        }
      });
      
      // Set initial per_page and offset
      per_page = parseInt($('#per_page').val());
      offset = (page-1) * per_page;
      
      // Update page navigation and select
      update_page_nav();
      update_page_select();
      
      // Attach handlers to results per page and sort selects
      $('#per_page').change(function() {
        per_page = parseInt($(this).val());
        offset = 0;
        update_page();
      });
      $('#sort').change(function() {
        sort = $(this).val();
        search(1);
      });
    }
  });
}

// Update the brief results for a new page
function update_page() {
  $('#brief-records, .page-nav').hide();
  $('#brief-loading').show();
  var slice_end = offset + per_page;
  var sliced_arks = arks.slice(offset, slice_end);
  $.ajax({
    url: "search-page.php",
    method: "post",
    data: {arks: sliced_arks, per_page: per_page, q: query, fq: filtered_query},
    success: function(results) {
      if (results != '') {
        $('#brief-loading').hide();
        $('#brief-records').html(results).fadeIn();
        update_page_nav();
        update_page_select();
        $('.page-nav').fadeIn();
      }
      else {
        search();
      }
    }
  });
  add_page_to_url();
  window.scrollTo(0, scroll_to);
}

function add_page_to_url() {
  var url = new URL(window.location);
  url.searchParams.set('p', (Math.floor(offset / per_page) + 1));
  window.history.replaceState({}, '', url);
}

// Show/hide pagination buttons
function update_page_nav() {
  var result_count = parseInt($('#result-count').text().replace(/,/g,''));
  var page_select = $('.page-select');
  
  // Previous
  if (offset > 0) {
    $('.prev button').show();
  }
  else {
    $('.prev button').hide();
  }
  
  // Next
  if ((offset + per_page) < result_count) {
    $('.next button').show();
  }
  else {
    $('.next button').hide();
  }

}

// Update the page select and total count
function update_page_select() {
  var ark_count = arks.length;
  var page_count = Math.ceil(ark_count / per_page);
  var page_select = $('.page-select');
  page_select.children('option').remove();
  for (p = 1; p <= page_count; p++) {
    page_select.append('<option value="' + p + '">' + p + '</option>');
  }
  $('.jump .total-pages').text(page_count);
  
  // Set selected page
  if (page_select.children('option').length > 1) {
    var current_page = Math.floor(offset / per_page) + 1;
    page_select.children('option').removeProp('selected')
      .parent().children('option[value="' + current_page + '"]').prop('selected', true);
    $('.jump p').show();
  }
  else {
    $('.jump p').hide();
  }
  
  // Attach handler
  page_select.change(function() {
    jump_to_page(this);
  });
}

// Navigate to a page
function nav_page(type) {
  var new_offset = 0;
  switch (type) {
    case 'prev':
      new_offset = offset - per_page;
      if (new_offset < 0) {
        new_offset = 0;
      }
    break;
    case 'next':
      new_offset = offset + per_page;
    break;
  }
  offset = new_offset;
  update_page();
}

// Jump to a page
function jump_to_page(select) {
  offset = (parseInt($(select).val()) - 1) * per_page;
  update_page();
}

// Show more facet entries
function expand_facets(btn) {
  var list = $(btn).prev('ul');
  var shown = list.children('li:visible').length;
  list.children('li:lt(' + (shown + 5) + ')').show();
  if (list.children('li:not(:visible)').length == 0) {
    btn.remove();
  }
}

// Remove applied facet and perform new search
function remove_facet(btn) {
  var facet = $(btn).parent();
  var facet_type = $(facet).data('type');
  var facet_term = encodeURIComponent($(facet).data('term'));
  
  var new_params = [];
  var urlParams = new URLSearchParams(window.location.search);
  if (urlParams.get('q') != null) {
    new_params.push('q=' + encodeURIComponent(urlParams.get('q')));
  }
  if (urlParams.get('r') != null && facet_type != 'repo') {
    new_params.push('r=' + encodeURIComponent(urlParams.get('r')));
  }
  var facets = urlParams.getAll('facet');
  for (var f = 0; f < facets.length; f++) {
    var split = facets[f].split(':');
    if (split[0] != facet_type && split[1] != facet_term) {
      new_params.push('facet=' + split[0] + ':' + encodeURIComponent(split[1]));
    }
  }
  window.location.assign('search.php?' + new_params.join('&'));
}

// Toggle facets for mobile
function toggle_facets() {
  if ($('#facets').is(':visible')) {
    $('#facets').hide();
    $('#finding-aids').show();
    $('#facets-toggle').text('Refine Search');
  }
  else {
    $('#facets').show();
    $('#finding-aids').hide();
    $('#facets-toggle').text('Back to Results');
  }
}
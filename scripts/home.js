$(document).ready(function(){
  
  // Load the RSS feed
  //$('#rss-content').load('https://archiveswest.orbiscascade.org/search/feed.aspx');

  // Load a picture for the banner
  var rnd = Math.floor((Math.random() * 12) + 1);
  $('#homesearchtop').css('background-image', 'url(layout/images/banner/' + rnd + '.jpg)');
	
	// Attach handlers to topic buttons
	$('.topicSearch button').click(function(){
	  $(this).parents('.topic').siblings('.topic').find('.searchterms').hide();
	  var sublist = $(this).siblings().eq(0);
	  sublist.toggle('fast', function() {
		  if ($(this).is(':visible')) {
			$(this).siblings('button').attr('aria-expanded', 'true');
		  }
		  else {
			$(this).siblings('button').attr('aria-expanded', 'false');
		  }
	  });
	});
    
});
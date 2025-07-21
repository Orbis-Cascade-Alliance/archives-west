$(document).ready(function(){

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
  
  // Alerts
  $.get('alert.php', {type: 'home'}, function(result) {
    $('#main-content').prepend(result);
  });
  
  // RSS
  $.get('rss-print.php', function(result) {
    $('#rss-content').html(result);
  });
    
});
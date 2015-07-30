// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require best_in_place
//= require bootstrap-sprockets
//= require nprogress
//= require nprogress-turbolinks


/* fading js */

// var fade_reply = function(){
//   tilers = $(".fade_speechr").fadeTo(0,0);

// $(window).scroll(function(d,h) {
//     tilers.each(function(i) {
//         a = $(this).offset().top + $(this).height();
//         b = $(window).scrollTop() + $(window).height() + 50 ;
//         if (a < b) $(this).fadeTo(500,1);
//     });
// });

// };
//  $(document).ready(fade_reply);
//  $(document).on('page:load', fade_reply);




/*page transiton */


$(window).ready(function(){
	var $container = $('.thread-row');
	$container.imagesLoaded( function (){
  		$container.masonry({
    	columnWidth: '.thread-col',
    	itemSelector: '.thread-col',
    	percentPosition: true
  		});
	});

	$('.pagination').hide();
	$('.thread-row').infinitescroll({
 
    navSelector  : ".pagination",            
                   // selector for the paged navigation (it will be hidden)
    nextSelector : "#page-links .next_page",    
                   // selector for the NEXT link (to page 2)
    itemSelector : ".thread-col",
                   // selector for all items you'll retrieve
    loadingText  : "<div id=\"loading\">Loading new posts...</div>",      
                 // text accompanying loading image
                 // default: "<em>Loading the next set of posts...</em>"
 
    animate      : false,      
                 // boolean, if the page will do an animated scroll when new content loads
                 // default: false
 
    extraScrollPx: 500,      
                 // number of additonal pixels that the page will scroll 
                 // (in addition to the height of the loading div)
                 // animate must be true for this to matter
                 // default: 150
 
    donetext     : "yey" 
                 // text displayed when all items have been retrieved
                 // default: "<em>Congratulations, you've reached the end of the internet.</em>"
 
  },function( newElements ) {
        // hide new items while they are loading
        var $newElems = $( newElements ).css({ opacity: 0 });
        // ensure that images load before adding to masonry layout
        $newElems.imagesLoaded(function(){
          // show elems now they're ready
          $newElems.animate({ opacity: 1 });
          $container.masonry( 'appended', $newElems, true );
        });
      });

$("#edit-profile-btn").click(function(){
  $("#profile-row").fadeOut();
  $("#edit-profile-row").fadeIn();
});

$("#edit-profile-btn-close").click(function(){
  $("#profile-row").fadeIn();
  $("#edit-profile-row").fadeOut();
});


});





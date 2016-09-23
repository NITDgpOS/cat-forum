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

});

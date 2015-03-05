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
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require best_in_place



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


var fade_thread = function(){
  tiles = $(".fade_speech").fadeTo(0,0);

$(window).scroll(function(d,h) {
    tiles.each(function(i) {
        a = $(this).offset().top + $(this).height();
        b = $(window).scrollTop() + $(window).height() + 200;
        if (a < b) $(this).fadeTo(500,1);
    });
});

};
 $(document).ready(fade_thread);
 $(document).on('page:load', fade_thread);


/*page transiton */








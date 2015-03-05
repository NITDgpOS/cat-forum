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





// Sticky Plugin v1.0.0 for jQuery
// =============
// Author: Anthony Garand
// Improvements by German M. Bravo (Kronuz) and Ruud Kamphuis (ruudk)
// Improvements by Leonardo C. Daronco (daronco)
// Created: 2/14/2011
// Date: 2/12/2012
// Website: http://labs.anthonygarand.com/sticky
// Description: Makes an element on the page stick on the screen as you scroll
//       It will only set the 'top' and 'position' of your element, you
//       might need to adjust the width in some cases.

// var ready = function(){
// $("h2.mntc").css("background-color","yellow");
// };


// $(document).ready(ready);
// $(document).on('page:load', ready);



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

var justsload = (function() {
    $('body').addClass('pt-page-scaleUpDown pt-page-delay300');  
});
$(document).on('page:load', justsload);


var justload = (function(){
   $('body').addClass('pt-page-scaleDown'); 
});
$(document).on('page:before-change', justload);







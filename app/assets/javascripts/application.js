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
//= require jquery.purr
//= require best_in_place
//= require html5shiv
//= require jquery.min
//= require rlsmooth 
//= require scripts


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

/* sticky heade */

(function($) {
  var defaults = {
      topSpacing: 0,
      bottomSpacing: 0,
      className: 'is-sticky',
      wrapperClassName: 'sticky-wrapper',
      center: false,
      getWidthFrom: ''
    },
    $window = $(window),
    $document = $(document),
    sticked = [],
    windowHeight = $window.height(),
    scroller = function() {
      var scrollTop = $window.scrollTop(),
        documentHeight = $document.height(),
        dwh = documentHeight - windowHeight,
        extra = (scrollTop > dwh) ? dwh - scrollTop : 0;

      for (var i = 0; i < sticked.length; i++) {
        var s = sticked[i],
          elementTop = s.stickyWrapper.offset().top,
          etse = elementTop - s.topSpacing - extra;

        if (scrollTop <= etse) {
          if (s.currentTop !== null) {
            s.stickyElement
              .css('position', '')
              .css('top', '');
            s.stickyElement.parent().removeClass(s.className);
            s.currentTop = null;
          }
        }
        else {
          var newTop = documentHeight - s.stickyElement.outerHeight()
            - s.topSpacing - s.bottomSpacing - scrollTop - extra;
          if (newTop < 0) {
            newTop = newTop + s.topSpacing;
          } else {
            newTop = s.topSpacing;
          }
          if (s.currentTop != newTop) {
            s.stickyElement
              .css('position', 'fixed')
              .css('top', newTop);

            if (typeof s.getWidthFrom !== 'undefined') {
              s.stickyElement.css('width', $(s.getWidthFrom).width());
            }

            s.stickyElement.parent().addClass(s.className);
            s.currentTop = newTop;
          }
        }
      }
    },
    resizer = function() {
      windowHeight = $window.height();
    },
    methods = {
      init: function(options) {
        var o = $.extend(defaults, options);
        return this.each(function() {
          var stickyElement = $(this);

          var stickyId = stickyElement.attr('id');
          var wrapper = $('<div></div>')
            .attr('id', stickyId + '-sticky-wrapper')
            .addClass(o.wrapperClassName);
          stickyElement.wrapAll(wrapper);

          if (o.center) {
            stickyElement.parent().css({width:stickyElement.outerWidth(),marginLeft:"auto",marginRight:"auto"});
          }

          if (stickyElement.css("float") == "right") {
            stickyElement.css({"float":"none"}).parent().css({"float":"right"});
          }

          var stickyWrapper = stickyElement.parent();
          stickyWrapper.css('height', stickyElement.outerHeight());
          sticked.push({
            topSpacing: o.topSpacing,
            bottomSpacing: o.bottomSpacing,
            stickyElement: stickyElement,
            currentTop: null,
            stickyWrapper: stickyWrapper,
            className: o.className,
            getWidthFrom: o.getWidthFrom
          });
        });
      },
      update: scroller,
      unstick: function(options) {
        return this.each(function() {
          var unstickyElement = $(this);

          removeIdx = -1;
          for (var i = 0; i < sticked.length; i++) 
          {
            if (sticked[i].stickyElement.get(0) == unstickyElement.get(0))
            {
                removeIdx = i;
            }
          }
          if(removeIdx != -1)
          {
            sticked.splice(removeIdx,1);
            unstickyElement.unwrap();
            unstickyElement.removeAttr('style');
          }
        });
      }
    };

  // should be more efficient than using $window.scroll(scroller) and $window.resize(resizer):
  if (window.addEventListener) {
    window.addEventListener('scroll', scroller, false);
    window.addEventListener('resize', resizer, false);
  } else if (window.attachEvent) {
    window.attachEvent('onscroll', scroller);
    window.attachEvent('onresize', resizer);
  }

  $.fn.sticky = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method ) {
      return methods.init.apply( this, arguments );
    } else {
      $.error('Method ' + method + ' does not exist on jQuery.sticky');
    }
  };

  $.fn.unstick = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method ) {
      return methods.unstick.apply( this, arguments );
    } else {
      $.error('Method ' + method + ' does not exist on jQuery.sticky');
    }

  };
  $(function() {
    setTimeout(scroller, 0);
  });
})(jQuery);

var ready = function(){
      $("#header").sticky({ topSpacing: 0 });
    };

    $(document).ready(ready);
    $(document).on('page:load', ready);


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



/*
* Curtain.js - Create an unique page transitioning system
* ---
* Version: 2
* Copyright 2011, Victor Coulon (http://victorcoulon.fr)
* Released under the MIT Licence
*/

(function ( $, window, document, undefined ) {

    var pluginName = 'curtain',
        defaults = {
            scrollSpeed: 400,
            bodyHeight: 0,
            linksArray: [],
            mobile: false,
            scrollButtons: {},
            controls: null,
            curtainLinks: '.curtain-links',
            enableKeys: true,
            easing: 'swing',
            disabled: false,
            nextSlide: function() {},
            prevSlide: function() {}
        };

    // The actual plugin constructor
    function Plugin( element, options ) {
        var self = this;

        // Public attributes
        this.element = element;
        this.options = $.extend( {}, defaults, options) ;

        this._defaults = defaults;
        this._name = pluginName;
        this._ignoreHashChange = false;

        this.init();
    }

    Plugin.prototype = {
        init: function () {
            var self = this;

            // Cache element
            this.$element = $(this.element);
            this.$li = $(this.element).find('>li');
            this.$liLength = this.$li.length;
            self.$windowHeight = $(window).height();
            self.$elDatas = {};
            self.$document = $(document);
            self.$window = $(window);


            self.webkit = (navigator.userAgent.indexOf('Chrome') > -1 || navigator.userAgent.indexOf("Safari") > -1);
            $.Android = (navigator.userAgent.match(/Android/i));
            $.iPhone = ((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i)));
            $.iPad = ((navigator.userAgent.match(/iPad/i)));
            $.iOs4 = (/OS [1-4]_[0-9_]+ like Mac OS X/i.test(navigator.userAgent));
            
            if($.iPhone || $.iPad || $.Android || self.options.disabled){
                this.options.mobile = true;
                this.$li.css({position:'relative'});
                this.$element.find('.fixed').css({position:'absolute'});
            }

            if(this.options.mobile){
               this.scrollEl =  this.$element;
            } else if($.browser.mozilla || $.browser.msie) {
                this.scrollEl = $('html');
            } else {
                this.scrollEl = $('body');
            }

            if(self.options.controls){
                self.options.scrollButtons['up'] =  $(self.options.controls).find('[href="#up"]');
                self.options.scrollButtons['down'] =  $(self.options.controls).find('[href="#down"]');

                if(!$.iOs4 && ($.iPhone || $.iPad)){
                    self.$element.css({
                        position:'fixed',
                        top:0,
                        left:0,
                        right:0,
                        bottom:0,
                        '-webkit-overflow-scrolling':'touch',
                        overflow:'auto'
                    });
                    $(self.options.controls).css({position:'absolute'});
                }
            }

            // When all image is loaded
            var callbackImageLoaded = function(){
                self.setDimensions();
                self.$li.eq(0).addClass('current');

                self.setCache();
                
                if(!self.options.mobile){
                    if(self.$li.eq(1).length)
                        self.$li.eq(1).nextAll().addClass('hidden');
                }

                self.setEvents();
                self.setLinks();
                self.isHashIsOnList(location.hash.substring(1));
            };

            if(self.$element.find('img').length)
                self.imageLoaded(callbackImageLoaded);
            else
                callbackImageLoaded();

        },
        // Events
        scrollToPosition: function (direction){
            var position = null,
                self = this;

            if(self.scrollEl.is(':animated')){
                return false;
            }

            if(direction === 'up' || direction == 'down'){
                // Keyboard event
                var $next = (direction === 'up') ? self.$current.prev() : self.$current.next();

                // Step in the current panel ?
                if(self.$step){

                    if(!self.$current.find('.current-step').length){
                        self.$step.eq(0).addClass('current-step');
                    }
                        
                    var $nextStep = (direction === 'up') ? self.$current.find('.current-step').prev('.step') : self.$current.find('.current-step').next('.step');

                    if($nextStep.length) {
                        position = (self.options.mobile) ? $nextStep.position().top + self.$elDatas[self.$current.index()]['data-position'] : $nextStep.position().top + self.$elDatas[self.$current.index()]['data-position'];
                    }
                }

                position = position || ((self.$elDatas[$next.index()] === undefined) ? null : self.$elDatas[$next.index()]['data-position']);

                if(position !== null){
                    self.scrollEl.animate({
                        scrollTop: position
                    }, self.options.scrollSpeed, self.options.easing);
                }

            } else if(direction === 'top'){
                self.scrollEl.animate({
                    scrollTop:0
                }, self.options.scrollSpeed, self.options.easing);
            } else if(direction === 'bottom'){
                self.scrollEl.animate({
                    scrollTop:self.options.bodyHeight
                }, self.options.scrollSpeed, self.options.easing);
            } else {
                var index = $("#"+direction).index(),
                    speed = Math.abs(self.currentIndex-index) * (this.options.scrollSpeed*4) / self.$liLength;

                self.scrollEl.animate({
                    scrollTop:self.$elDatas[index]['data-position'] || null
                }, (speed <= self.options.scrollSpeed) ? self.options.scrollSpeed : speed, this.options.easing);
            }
            
        },
        scrollEvent: function() {
            var self = this,
                docTop = self.$document.scrollTop();

            if(docTop < self.currentP && self.currentIndex > 0){
                // Scroll to top
                self._ignoreHashChange = true;

                if(self.$current.prev().attr('id'))
                    self.setHash(self.$current.prev().attr('id'));
                
                self.$current
                    .removeClass('current')
                    .css( (self.webkit) ? {'-webkit-transform': 'translateY(0px) translateZ(0)'} : {marginTop: 0} )
                    .nextAll().addClass('hidden').end()
                    .prev().addClass('current').removeClass('hidden');
  
                self.setCache();
                self.options.prevSlide();

            } else if(docTop < (self.currentP + self.currentHeight)){

                // Animate the current pannel during the scroll
                if(self.webkit)
                    self.$current.css({'-webkit-transform': 'translateY('+(-(docTop-self.currentP))+'px) translateZ(0)' });
                else
                    self.$current.css({marginTop: -(docTop-self.currentP) });

                // If there is a fixed element in the current panel
                if(self.$fixedLength){
                    var dataTop = parseInt(self.$fixed.attr('data-top'), 10);

                    if(docTop + self.$windowHeight >= self.currentP + self.currentHeight){
                        self.$fixed.css({
                            position: 'fixed'
                        });
                    } else {
                        self.$fixed.css({
                            position: 'absolute',
                            marginTop: Math.abs(docTop-self.currentP)
                        });
                    }
                }
                
                // If there is a step element in the current panel
                if(self.$stepLength){
                    $.each(self.$step, function(i,el){
                        if(($(el).position().top+self.currentP) <= docTop+5 && $(el).position().top + self.currentP + $(el).height() >= docTop+5){
                            if(!$(el).hasClass('current-step')){
                                self.$step.removeClass('current-step');
                                $(el).addClass('current-step');
                                return false;
                            }
                        }
                    });
                }


                if(self.parallaxBg){
                    self.$current.css({
                        'background-position-y': docTop * self.parallaxBg
                    });
                }

                if(self.$fade.length){
                    self.$fade.css({
                        'opacity': 1-(docTop/ self.$fade.attr('data-fade'))
                    });
                }

                if(self.$slowScroll.length){
                    self.$slowScroll.css({
                        'margin-top' : (docTop / self.$slowScroll.attr('data-slow-scroll'))
                    });
                }

            } else {
                // Scroll bottom
                self._ignoreHashChange = true;
                if(self.$current.next().attr('id'))
                    self.setHash(self.$current.next().attr('id'));

                self.$current.removeClass('current')
                    .addClass('hidden')
                    .next('li').addClass('current').next('li').removeClass('hidden');

                self.setCache();
                self.options.nextSlide();
            }

        },
        scrollMobileEvent: function() {
            var self = this,
                docTop = self.$element.scrollTop();

            if(docTop+10 < self.currentP && self.currentIndex > 0){

                // Scroll to top
                self._ignoreHashChange = true;

                if(self.$current.prev().attr('id'))
                    self.setHash(self.$current.prev().attr('id'));

                self.$current.removeClass('current').prev().addClass('current');
                self.setCache();
                self.options.prevSlide();
            } else if(docTop+10 < (self.currentP + self.currentHeight)){

                // If there is a step element in the current panel
                if(self.$stepLength){
                    $.each(self.$step, function(i,el){
                        if(($(el).position().top+self.currentP) <= docTop && (($(el).position().top+self.currentP) + $(el).outerHeight()) >= docTop){
                            if(!$(el).hasClass('current-step')){
                                self.$step.removeClass('current-step');
                                $(el).addClass('current-step');
                            }
                        }
                    });
                }

            } else {

                // Scroll bottom
                self._ignoreHashChange = true;
                if(self.$current.next().attr('id'))
                    self.setHash(self.$current.next().attr('id'));

                self.$current.removeClass('current').next().addClass('current');
                self.setCache();
                self.options.nextSlide();
            }


        },
        // Setters
        setDimensions: function(){
   


   
  var load_curtain = function(){
       $('.curtains').curtain({
           scrollSpeed: 300,
           controls: '.menu',
           curtainLinks: '.curtain-links',
           nextSlide: function(){
            console.log("ok");
           }
       });
    };
   $(document).ready(load_curtain);
 $(document).on('page:load', load_curtain);


$(function(){
       $('.curtains').curtain({
           scrollSpeed: 300,
           controls: '.menu',
           curtainLinks: '.curtain-links',
           nextSlide: function(){
            console.log("ok");
           }
       });
    });         var self = this,
                levelHeight = 0,
                cover = false,
                height = null;
            
            self.$windowHeight = self.$window.height();

            this.$li.each(function(index) {
                var $self = $(this);
                cover = $self.hasClass('cover');

                if(cover){
                    $self.css({height: self.$windowHeight, zIndex: 2-index})
                        .attr('data-height',self.$windowHeight)
                        .attr('data-position',levelHeight);

                    self.$elDatas[$self.index()] = {
                        'data-height': parseInt(self.$windowHeight,10),
                        'data-position': parseInt(levelHeight, 10)
                    };

                    levelHeight += self.$windowHeight;

                } else{
                    height = ($self.outerHeight() <= self.$windowHeight) ? self.$windowHeight : $self.outerHeight();
                    $self.css({minHeight: height, zIndex: 1-index})
                        .attr('data-height',height)
                        .attr('data-position',levelHeight);
                    
                     self.$elDatas[$self.index()] = {
                        'data-height': parseInt(height, 10),
                        'data-position': parseInt(levelHeight, 10)
                    };

                    levelHeight += height;
                }

                if($self.find('.fixed').length){
                    var top = $self.find('.fixed').css('top');
                    $self.find('.fixed').attr('data-top', top);
                }
            });
            if(!this.options.mobile)
                this.setBodyHeight();
        },
        setEvents: function() {
            var self = this;

            $(window).on('resize', function(){
                self.setDimensions();
            });

            if(self.options.mobile) {
                self.$element.on('scroll', function(){
                    self.scrollMobileEvent();
                });
            } else {
                self.$window.on('scroll', function(){
                    self.scrollEvent();
                });
            }
            
            if(self.options.enableKeys) {
                self.$document.on('keydown', function(e){
                    if(e.keyCode === 38 || e.keyCode === 37) {
                        self.scrollToPosition('up');
                        e.preventDefault();
                        return false;
                    }
                    if(e.keyCode === 40 || e.keyCode === 39){
                        self.scrollToPosition('down');
                        e.preventDefault();
                        return false;
                    }
                    // Home button
                    if(e.keyCode === 36){
                        self.scrollToPosition('top');
                        e.preventDefault();
                        return false;
                    }
                    // End button
                    if(e.keyCode === 35){
                        self.scrollToPosition('bottom');
                        e.preventDefault();
                        return false;
                    }
                });
            }

            if(self.options.scrollButtons){
                if(self.options.scrollButtons.up){
                    self.options.scrollButtons.up.on('click', function(e){
                        e.preventDefault();
                        self.scrollToPosition('up');
                    });
                }
                if(self.options.scrollButtons.down){
                    self.options.scrollButtons.down.on('click', function(e){
                        e.preventDefault();
                        self.scrollToPosition('down');
                    });
                }
            }

            if(self.options.curtainLinks){
                $(self.options.curtainLinks).on('click', function(e){
                    e.preventDefault();
                    var href = $(this).attr('href');
                    
                    if(!self.isHashIsOnList(href.substring(1)) && position)
                        return false;
                    var position = self.$elDatas[$(href).index()]['data-position'] || null;

                    if(position){
                        self.scrollEl.animate({
                            scrollTop:position
                        }, self.options.scrollSpeed, self.options.easing);
                    }
                    return false;
                });
            }

            self.$window.on("hashchange", function(event){
                if(self._ignoreHashChange === false){
                    self.isHashIsOnList(location.hash.substring(1));
                }
                self._ignoreHashChange = false;
            });
        },
        setBodyHeight: function(){
            var h = 0;

            for (var key in this.$elDatas) {
               var obj = this.$elDatas[key];
               h += obj['data-height'];
            }
  
            this.options.bodyHeight = h;
            $('body').height(h);
        },
        setLinks: function(){
            var self = this;
            this.$li.each(function() {
                var id = $(this).attr('id') || 0;
                self.options.linksArray.push(id);
            });
        },
        setHash: function(hash){
            // "HARD FIX"
            el = $('[href=#'+hash+']');
            el.parent().siblings('li').removeClass('active');
            el.parent().addClass('active');

            if(history.pushState) {
                history.pushState(null, null, '#'+hash);
            }
            else {
                location.hash = hash;
            }
        },
        setCache: function(){
            var self = this;
            self.$current = self.$element.find('.current');
            self.$fixed = self.$current.find('.fixed');
            self.$fixedLength = self.$fixed.length;
            self.$step = self.$current.find('.step');
            self.$stepLength = self.$step.length;
            self.currentIndex = self.$current.index();
            self.currentP = self.$elDatas[self.currentIndex]['data-position'];
            self.currentHeight = self.$elDatas[self.currentIndex]['data-height'];

            self.parallaxBg = self.$current.attr('data-parallax-background');
            self.$fade = self.$current.find('[data-fade]');
            self.$slowScroll = self.$current.find('[data-slow-scroll]');

        },
        // Utils
        isHashIsOnList: function(hash){
            var self = this;
            $.each(self.options.linksArray, function(i,val){
                if(val === hash){
                    self.scrollToPosition(hash);
                    return false;
                }
            });
        },
        readyElement: function(el,callback){
          var interval = setInterval(function(){
            if(el.length){
              callback(el.length);
              clearInterval(interval);
            }
          },60);
        },
        imageLoaded: function(callback){
            var self = this,
                elems = self.$element.find('img'),
                len   = elems.length,
                blank = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";

            elems.bind('load.imgloaded',function(){
                if (--len <= 0 && this.src !== blank || $(this).not(':visible')){
                    elems.unbind('load.imgloaded');
                    callback.call(elems,this);
                }
            }).each(function(){
                if (this.complete || this.complete === undefined){
                    var src = this.src;
                    this.src = blank;
                    this.src = src;
                }
            });
        }
    };



    $.fn[pluginName] = function ( options ) {
        return this.each(function () {
            if (!$.data(this, 'plugin_' + pluginName)) {
                $.data(this, 'plugin_' + pluginName, new Plugin( this, options ));
            }
        });
    };


})( jQuery, window, document );



  var load_curtain = function(){
       $('.curtains').curtain({
           scrollSpeed: 300,
           controls: '.menu',
           curtainLinks: '.curtain-links',
           nextSlide: function(){
            console.log("ok");
           }
       });
    };
   $(document).ready(load_curtain);
 $(document).on('page:load', load_curtain);



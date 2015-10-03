/** Modify the layout so there are only tree cols in row*/
$(document).ready(function() {
  sameWidthOptionButtons();
  sameHeightMiddleClass();
  sameHeightContentClass();
});

$(window).resize(function() {
  sameWidthOptionButtons();
  sameHeightMiddleClass();
  sameHeightContentClass();
});

function sameHeightMiddleClass() {
  var heights = $(".middle-class").map(function () {
          return $(this).height();
      }).get(),

      maxHeight = Math.max.apply(null, heights);

  $(".middle-class").height(maxHeight);
}

function sameHeightContentClass() {
  var heights = $(".content-class").map(function () {
          return $(this).height();
      }).get(),

      maxHeight = Math.max.apply(null, heights);

  $(".content-class").height(maxHeight);
}

function sameWidthOptionButtons() {
  var widths = $(".option-buttons").map(function () {
          return $(this).width();
      }).get(),

      maxWidth = Math.max.apply(null, widths);

  $(".option-buttons").width(maxWidth);
}

// /** to collapse the navbar on scroll */
// $(window).scroll(function() {
//     if ($(".navbar").offset().top > 50) {
//         $(".navbar-fixed-top").addClass("top-nav-collapse");
//     } else {
//         $(".navbar-fixed-top").removeClass("top-nav-collapse");
//     }
// });
//
// // /** Closes the Responsive Menu on Menu Item Click */
// // $('.navbar-collapse ul li a').click(function() {
// //     $('.navbar-toggle:visible').click();
// // });
//
// /** jQuery for page scrolling feature - requires jQuery Easing plugin */
// $(function() {
//     $('a.page-scroll').bind('click', function(event) {
//         var $anchor = $(this);
//         $('html, body').stop().animate({
//             scrollTop: $($anchor.attr('href')).offset().top
//         }, 1500, 'easeInOutExpo');
//         event.preventDefault();
//     });
// });
//
// // Opens and Closes the sidebar menu
// $(function() {
//     $("#menu-toggle").click(function(e) {
//       e.preventDefault();
//       $("#sidebar-wrapper").toggleClass("active");
//       $("#menu-arrow").toggleClass("glyphicon glyphicon-menu-right glyphicon glyphicon-menu-left");
//       if($("#sidebar-wrapper").hasClass("active")) {
//         $("#content-container").fadeTo(600, 0.4);
//       } else {
//         $("#content-container").fadeTo(600, 1.0);
//       }
//     });
// });
//
// // Closes the sidebar menu if user clicks on content
// $(function() {
//   $("#content-container").click(function(e) {
//     if($("#sidebar-wrapper").hasClass("active")) {
//       $("#menu-toggle").click();
//     }
//   });
// });
//
//
// // // Opens the sidebar menu
// // $(function(){
// //     $("#menu-toggle").click(function(e) {
// //         e.preventDefault();
// //         $("#sidebar-wrapper").toggleClass("active");
// //
// //         $("#menu-arrow").attr("class", "glyphicon glyphicon-menu-right");
// //
// //
// //
// //         // $("body").fadeTo(600, 0.4);
// //     });
// // });
//
// // Scrolls to the selected menu item on the page
// /**
//
// $(function() {
//     $('a[href*=#]:not([href=#])').click(function() {
//         if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') || location.hostname == this.hostname) {
//
//             var target = $(this.hash);
//             target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
//             if (target.length) {
//                 $('html,body').animate({
//                     scrollTop: target.offset().top
//                 }, 1000);
//                 return false;
//             }
//         }
//     });
// });*/
//
// $(document).ready(function(){
//    $('.bxSlider').bxSlider({
//        auto: false,
//        captions: true,
//        default: 'horizontal',
//        options: true,
//        infiniteLoop: true
//    });
// });
//
// $(function(){
//
//     var image_pos = 0;
//     var image_count = $(".slider > img").size();
//     console.log(image_count);
//
//     $('.slider #'+image_pos).fadeIn(500);
//     $('.slider #'+image_pos).delay(5000).fadeOut(500);
//
//     image_pos = image_pos + 1;
//     setInterval(function(){
//
//         $('.slider #'+image_pos).fadeIn(500);
//         $('.slider #'+image_pos).delay(5000).fadeOut(500);
//         image_pos = image_pos + 1;
//         if(image_pos==image_count){
//             image_pos = 0;
//         }
//
//     }, 6500);
//
//
//     /**
//     $(".slider #"+image_pos).show("fade", 500);
//     setInterval(function(){
//
//         $(".slider #"+image_pos).show("slide", {direction: "right"}, 500);
//         $(".slider #"+image_pos).delay(5000).hide("slide", {direction: "left"}, 500);
//
//         image_pos++;
//         if(image_pos==image_count){
//             image_pos = 0;
//         }
//     },6500);
// */
// });

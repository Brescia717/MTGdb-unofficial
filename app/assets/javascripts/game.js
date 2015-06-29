$(document).ready(function() {
  "use strict";

  $(".card").addClass(function(index) {
    return "index-" + index;
  });

  $(".card").on('click', function() {
    var card = $(this);

    if (card.hasClass("hand") === true) {
      card.removeClass("hand");
      card.addClass("in_play");
      $('#battlefield').append( card );
    }

    if (card.hasClass("in_play")) {
      card.addClass("untapped");
      card.on('click', function() {
        if (card.hasClass("untapped")) {
          card.addClass("tapped");
          card.removeClass("untapped");
          TweenMax.to(".tapped img", 0.25, {rotation:90});
        } else if (card.hasClass("tapped")) {
          card.addClass("untapped");
          card.removeClass("tapped");
          TweenMax.to(".untapped img", 0.25, {rotation:0});
        }
      });
    }

    if (card.hasClass("library") === true) {
      card.removeClass("library");
      card.addClass("hand");
      $("#hand").append( card );
    }
  });
  // var i = 1;
  // if (i < 60) {
  //   var topCard = $('#library span:nth-last-child('+ i +')')
  //   $('#draw_button').on('click', function() {
  //     topCard.removeClass("library");
  //     topCard.addClass("hand");
  //     $("#hand").append( topCard );
  //   });
  //   i = i + 1;
  // }

});

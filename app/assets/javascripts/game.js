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
        card.toggleClass("tapped");
        card.toggleClass("untapped");
      });
      if (card.hasClass('tapped')) {
        TweenMax.to(".tapped img", 0.5, {rotation:90});
      } else {
        TweenMax.to(".untapped img", 0.5, {rotation:0});
      }
    }

    if (card.hasClass("library") === true) {
      card.removeClass("library");
      card.addClass("hand");
      $("#hand").append( card );
    }

  });
});

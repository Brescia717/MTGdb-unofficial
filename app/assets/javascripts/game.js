$(document).ready(function() {
  "use strict";
  $(".card").addClass(function(index){
    return "index-" + index;
  });

  $(".card").on('click', function() {
    var card = $(this);
    if (card.hasClass("hand") == true) {
      card.removeClass("hand");
      card.addClass("in_play");
      $('#battlefield').append( card );
    } else if (card.hasClass("in_play") == true) {
      card.rotate(90);
    };
    if (card.hasClass("library") == true) {
      card.removeClass("library");
      card.addClass("hand");
      $("#hand").append( card );
    }
  });
});

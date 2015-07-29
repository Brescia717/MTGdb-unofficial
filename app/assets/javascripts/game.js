$(document).ready(function() {
  'use strict';

  $('.card').addClass(function(index) {
    return 'index-' + index;
  });
  $('.card').draggable();
  $('.card').on('click', function() {
    var card = $(this);

    if (card.hasClass('hand') === true) {
      card.switchClass('hand', 'in_play', 'fast');
      $('#battlefield').append( card );
    }
    if (card.hasClass('in_play')) {
      card.addClass('untapped');
      card.on('click', function() {
        if (card.hasClass('untapped')) {
          card.switchClass('untapped', 'tapped', 'fast');
          TweenMax.to('.tapped img', 0.25, {rotation:90});
        } else if (card.hasClass('tapped')) {
          card.switchClass('tapped', 'untapped', 'fast');
          TweenMax.to('.untapped img', 0.25, {rotation:0});
        }
      });
    }
  });

  $('#draw_button').on('click', function() {
    $('#library span').first().appendTo('#hand').removeClass('library').addClass('hand');
  });

});

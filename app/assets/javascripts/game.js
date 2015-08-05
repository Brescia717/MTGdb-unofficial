$(document).ready(function() {
  'use strict';

  $('.card').addClass(function(index) {
    return 'index-' + index;
  });
  $('.card').draggable();
  $('.card').addClass('clickable');
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

  // Trigger action when the contexmenu is about to be shown
  $('.clickable').on("contextmenu", function (event) {

      // Avoid the real one
      event.preventDefault();

      // Show contextmenu
      $(".custom-menu").finish().toggle(100).

      // In the right position (the mouse)
      css({
          top: event.pageY + "px",
          left: event.pageX + "px"
      });
  });


  // If the document is clicked somewhere
  $(document).on("mousedown", function (e) {

      // If the clicked element is not the menu
      if (!$(e.target).parents(".custom-menu").length > 0) {

          // Hide it
          $(".custom-menu").hide(100);
      }
  });

  $('.clickable').on('contextmenu', function() {
    var card = $(this);
    // If the menu element is clicked
    $(".custom-menu li").on('click', function(){

      // This is the triggered action name
      switch($(this).attr("data-action")) {

          // A case for each action. Your actions here
          case "first":
            card.
            removeClass('untapped tapped in_play hand graveyard').
            addClass('graveyard').
            appendTo('#graveyard');
            TweenMax.to('.graveyard img', 0.25, {rotation:90});
            break;
          case "second":
            card.
            removeClass('tapped untapped in_play hand graveyard').
            addClass('hand').
            appendTo('#hand');
            TweenMax.to('.hand img', 0.25, {rotation:0});
            break;
          // case "third": $('.me').prependTo('.gy'); break;
      }

      // Hide it AFTER the action was triggered
      $(".custom-menu").hide(100);
    });
  });

});

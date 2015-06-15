$(function () {
  // Sorting and pagination links
  $('#cards').on('click', 'th a, .pagination a', function () {
      $.getScript(this.href);
      return false;
    }
  );
  $('#deck-cards').on('click', 'th a, .pagination a', function () {
      $.getScript(this.href);
      return false;
    }
  );
});
// $(function() {
//   (function( $ ) {
//     $.fn.ajaxMyLinks = function () {
//       this.on("click", function(event) {
//         event.preventDefault;
//         $.getScript(this.href);
//         return false;
//     }
//   });
//   $(".pagination a").ajaxMyLinks();
//   $("th a").ajaxMyLinks();
// });

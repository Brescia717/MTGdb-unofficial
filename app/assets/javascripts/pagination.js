$(function() {
  $(".pagination a").on("click", function(event) {
    event.preventDefault;
    $.get(this.href, null, null, "script");
    return false;
  });
  $(".card_search submit").live("click", function() {
    event.preventDefault;
    $.get(this.href, null, null, "script");
    return false;
  });
  // $(".sort a .sort_link").live("click", function() {
  //   event.preventDefault;
  //   $.get(this.href, null, null, "script");
  //   return false;
  // });
});

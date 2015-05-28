$(function() {
  $(".pagination a").on("click", function(event) {
    event.preventDefault;
    $.get(this.href, null, null, "script");
    return false;
  });
});

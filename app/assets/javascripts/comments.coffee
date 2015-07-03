ready = ->
  $('.best_in_place').best_in_place()

  $('#comment_edit_btn').on 'click',  ->
    $('#comment').find('p span').trigger 'click'

  # $('#comment_delete_btn').on 'click', ->
  #       $(this).closest('span').fadeOut()
  #       return

$(document).ready(ready)
$(document).on('page:load', ready)

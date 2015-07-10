ready = ->
  $('.best_in_place').best_in_place()


  $('.comment_edit_btn').each ->
    $(this).on 'click', ->
      $(this).closest('div').find('span').trigger 'click'
      return
    return


  # $('#comment').attr 'id', ->
  #   $(this).find('span').attr 'id'
  # $('#comment_delete_btn').each ->
  #   $(this).on 'click', ->
  #     if confirm('Are you sure you want to delete this comment?') == true
  #       $(this).closest('div').fadeOut()
  #     else
  #       return
  #     return
  #   return

$(document).ready(ready)
$(document).on('page:load', ready)

jQuery ->
  $('#cards_autocomplete_name').autocomplete
    source: "/search_suggestions"
  $('span').hidden
  $('#adv_opts').click ->
      $('p').toggle 'slow'
      return

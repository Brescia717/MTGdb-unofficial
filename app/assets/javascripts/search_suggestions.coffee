jQuery ->
  $('#cards_autocomplete_name').autocomplete
    source: "/search_suggestions"
  $('#deck_search').autocomplete
    source: "/search_suggestions"
  $('span').hidden
  $('#adv_opts').click ->
      $('.search-form p').toggle 'slow'
      return

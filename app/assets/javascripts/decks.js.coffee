jQuery ->
  $('#card_search').autocomplete
    source: $('#card_search').data('autocomplete-source')

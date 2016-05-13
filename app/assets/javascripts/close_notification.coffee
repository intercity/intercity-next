$(document).on 'click', '.notification > button.delete', ->
  $(this).parent().addClass 'is-hidden'

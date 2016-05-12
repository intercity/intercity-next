$(document).on 'click', "[data-behaviour~=close-modal], .modal-close, .modal-background", (e) ->
  e.preventDefault()
  modal = $(this).closest('.modal')
  modal.find('form').trigger('reset')
  modal.removeClass('is-active')

$(document).on 'click', '[data-behaviour="open-modal"]', (e) ->
  e.preventDefault()
  $($(this).data('target-modal')).addClass('is-active')

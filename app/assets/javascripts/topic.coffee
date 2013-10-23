init_reply = ->
  $('.ui.dropdown').dropdown
    on: 'hover'
  $('.ui.main.menu .popup.item').popup
    position : 'bottom center'

  $('#replies').on 'click', '.icon-reply', ->
    reply_body = $('#reply_body')
    text = "#{reply_body.val()}@#{$(this).data('username')} "
    reply_body.focus().val(text)

$(document).ready(init_reply)
$(document).on('page:load', init_reply)

init_reply = ->
  $('#replies').on 'click', '.icon-reply', ->
    reply_body = $('#reply_body')
    text = "#{reply_body.val()}@#{$(this).data('username')} "
    reply_body.focus().val(text)

$(document).ready(init_reply)
$(document).on('page:load', init_reply)

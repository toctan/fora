ready = ->
  $('#replies').on 'click', '.icon-reply', ->
    reply_body = $('#reply_body')
    text = "#{reply_body.val()}@#{$(this).data('username')} "
    reply_body.focus().val(text)

$(document).ready(ready)
$(document).on('page:load', ready)

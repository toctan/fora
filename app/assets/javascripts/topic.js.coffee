$ ->
  $('.js-autohtml').autohtml()

  $('.js-share').share()

  $('textarea').autosize
    append: "\n"

  $('#replies').on 'click', '.js-reply', (event) ->
    event.preventDefault()
    $reply_body = $('#reply_body')
    text = "#{$reply_body.val()}@#{$(@).data('name')} "
    $reply_body.focus().val text

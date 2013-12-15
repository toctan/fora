#= require jquery.autosize
#= require jquery.autohtml
#= require share

@Topic =
  newReply: (name) ->
    $reply_body = $('#reply_body')
    text = "#{$reply_body.val()}@#{name} "
    $reply_body.focus().val text

  fetchReplies: ->
    $last_reply = $('.reply').last()

    if $last_reply.length
      $.get "#{location.pathname}/replies",
        since_id: $last_reply.attr('id').split('_')[1]
    else
      Turbolinks.visit location.href

  appendReplies: (replies) ->
    return if replies.length = 0

    if $('#replies').length
      $(replies)
        .hide()
        .toggleClass('yellow-fade')
        .appendTo('#replies')
        .show('slow')

      $('.yellow-fade .js-autohtml')
        .autohtml()
        .removeClass('js-autohtml')
    else
      Turbolinks.visit location.href

$ ->
  $('.js-autohtml').autohtml()

  $('.js-share').share()

  $('textarea').autosize
    append: "\n"

  $('#replies').on 'click', '.js-reply', (event) ->
    event.preventDefault()
    Topic.newReply $(@).data('name')

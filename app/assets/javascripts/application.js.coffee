#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require jquery.timeago
#= require jquery.autosize
#= require nprogress
#= require semantic-ui/transition
#= require semantic-ui/dropdown
#= require semantic-ui/popup
#= require_tree .
#= require turbolinks

$ ->
  $('.js-timeago').timeago()

  $('textarea').autosize
    append: "\n"

  $('.message .close.icon').click ->
    $(@).parent().transition 'slide down'

  $('.ui.dropdown').dropdown
    on: 'hover'

  $('.site-nav .popup').popup
    position : 'bottom center'

$(document).on 'page:fetch',   -> NProgress.start()
$(document).on 'page:change',  -> NProgress.done()
$(document).on 'page:restore', -> NProgress.remove()

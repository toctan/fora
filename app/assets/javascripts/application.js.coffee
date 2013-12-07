#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require jquery.timeago
#= require jquery.autosize
#= require jquery.autohtml
#= require nprogress
#= require turbolinks

$ ->
  $('.js-timeago').timeago()

  $('.js-autohtml').autohtml()

  $('textarea').autosize
    append: "\n"

$(document).on 'page:fetch',   -> NProgress.start()
$(document).on 'page:change',  -> NProgress.done()
$(document).on 'page:restore', -> NProgress.remove()

#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require jquery.timeago
#= require topic
#= require nprogress
#= require turbolinks

$ ->
  $('.js-timeago').timeago()

$(document).on 'page:fetch',   -> NProgress.start()
$(document).on 'page:change',  -> NProgress.done()
$(document).on 'page:restore', -> NProgress.remove()

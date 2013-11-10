#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require jquery.timeago
#= require semantic-ui/transition
#= require semantic-ui/dropdown
#= require semantic-ui/popup
#= require_tree .
#= require turbolinks

$ ->
  $('.js-timeago').timeago()

$ = jQuery

class AutoHTML
  constructor: (@html) ->

  set_html: (html) ->
    @html = html.replace('<p></p>', '')
      .replace('<p><br>', '<p>')
      .replace('<br></p>', '</p>')
    return this

  all: (html) ->
    @simpleFormat()
      .mention()
      .image()
      .twitter()
      .youtube()
      .vimeo()
      .youku()
      .tudou()
      .gist()
      .link()
      .html

  simpleFormat: ->
    @set_html @html.replace(/\n{2,}/g, '</p><p>')
      .replace(/\n/g, '<br>')
      .replace(/^(<p>)*/, '<p>')
      .replace(/(<\/p>)*$/, '</p>')

  mention: ->
    regex = /@\w+/g
    @set_html @html.replace regex, (match, offset, str) ->
      return match if match.length > 20
      "<a href=\"/#{match}\">#{match}</a>"

  link: ->
    regex = ///((https?|ftp)://[\w?=&./-;#~%-]+(?![\w\s?&./;#~%"=-]*>))///gi
    @set_html @html.replace regex, '<a href="$1">$1</a>'

  image: ->
    regex = ///https?://.+\.(jpg|jpeg|bmp|gif|png)(\?\S+)?///gi
    @set_html @html.replace regex, '<img src="$&" alt>'

  twitter: ->
    regex = ///https://twitter\.com/[A-Za-z0-9_]{1,15}/status(es)?/\d+///gi
    @set_html @html.replace regex, '
</p><blockquote class="twitter-tweet"><a href="$&"></a></blockquote>
<script async src="//platform.twitter.com/widgets.js"></script><p>'

  youtube: ->
    regex = ///https?://(www.)?
      (youtube\.com/watch\?v=|youtu\.be/)
      ([A-Za-z0-9_-]*)(\&\S+)?[\w?=&./-;#~%]*
    ///gi
    @set_html @html.replace regex, '</p><div class="video-wrapper">
<iframe width="640" height="360" src="//www.youtube.com/embed/$3" frameborder="0" allowfullscreen>
</iframe></div><p>'

  vimeo: ->
    regex = ///https?://(www.)?vimeo\.com/(\w+/)*(\d+)((\?|#)\S+)?///gi
    @set_html @html.replace regex, '</p><div class="video-wrapper">
<iframe width="640" height="360" src="//player.vimeo.com/video/$3" frameborder="0" allowfullscreen>
</iframe></div><p>'

  youku: ->
    regex = ///http://v.youku.com/v_show/id_(\w+)(\.)?[\w?=&./-;#~%]*///gi
    @set_html @html.replace regex, '</p><div class="video-wrapper">
<iframe width="640" height="360" src="//player.youku.com/embed/$1" frameborder="0" allowfullscreen>
</iframe></div><p>'

  tudou: ->
    regex = ///https?://(www.)?tudou\.com/
      (\w)(istplay|lbumplay|iew)/
      ([\w-]+)[\w?=&./-;#~%]*
    ///gi
    @set_html @html.replace regex, '</p><div class="video-wrapper">
<embed width="640" height="360" src="//www.tudou.com/$2/$4"
 type="application/x-shockwave-flash" allowfullscreen allowscriptaccess="always"
 wmode="opaque"></embed></div><p>'

  gist: ->
    regex = ///https?:(//gist\.github\.com/(\w+)?/(\d+))///gi
    @set_html @html.replace regex, (match, p1, p2, p3, offset, str) ->
      "<script id=gist-#{p3}>$.getJSON(\"#{p1 + '.json?callback=?'}\", function(data) {
$('#gist-#{p3}').replaceWith($(data.div + '<link rel=\"stylesheet\"
 href=\"//gist.github.com/' + data.stylesheet + '\">'));});</script>"

$.autohtml = (html) ->
  return html if html is ''
  new AutoHTML(html).all()

$.fn.autohtml = ->
  @each -> $(@).html new AutoHTML($(@).html()).all()

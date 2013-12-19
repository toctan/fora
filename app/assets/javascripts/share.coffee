$.fn.share = (opts = {}) ->
  @each ->
    $this = $(@)
    $this.on 'click', (event) ->
      event.preventDefault()

      $offsetParent = $this.offsetParent()

      url = encodeURIComponent(
        if opts.url
          opts.url
        else if $offsetParent.attr('id')
          "#{window.location.href}##{$offsetParent.attr('id')}"
        else
          window.location.href
        )

      text = encodeURIComponent(opts.text || $offsetParent.find($this.
        data('text-selector')).text()).slice(0, 140)

      paths =
        twitter: "http://twitter.com/intent/tweet?url=#{url}&text=#{text}"
        weibo: "http://service.weibo.com/share/share.php?url=#{url}&title=#{text}"

      link = paths[$this.data('network')]
      window.open link, 'targetWindow', 'toolbar=no,location=no,status=no,
menubar=no,scrollbars=yes,resizable=yes,width=500,height=350'

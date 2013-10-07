share = (site, title, url) ->
  switch site
    when 'twitter'
      href = "https://twitter.com/home?status=#{title}: #{url}"
    when 'weibo'
      href = "http://service.weibo.com/share/share.php?url=#{url}&type=3&pic=#{img}&title=#{title}"

  window.open(href)

init_share = ->
  $("#share").on 'click', '.share', ->
    site = $(this).data("site")
    title = $("#share").data("title")
    url = location.href

    share(site, title, url)

$(document).ready(init_share)
$(document).on('page:load', init_share)

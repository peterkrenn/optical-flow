$ ->
  setActive()
  $('nav a').live 'click', ->
    $('#content').load(@href)
    history.pushState(null, '', @href)
    setActive()
    false

$(window).bind 'popstate', ->
  $('#content').load(location.href)
  setActive()

setActive = ->
  items = $('nav a')
  items.removeClass('active')
  $(item for item in items when item.pathname == location.pathname).addClass('active')

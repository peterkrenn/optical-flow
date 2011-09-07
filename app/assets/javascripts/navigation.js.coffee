$ ->
  items = $('nav a')
  items.first().addClass('active')
  items.live 'click', ->
      $('#content').load(@href)
      items.removeClass('active')
      $(this).addClass('active')
      false

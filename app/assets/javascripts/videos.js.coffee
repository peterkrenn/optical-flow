$ ->
  loadWorkers = ->
    $('#worker_list').load('/workers')
  loadWorkers()
  setInterval(loadWorkers, 2000)

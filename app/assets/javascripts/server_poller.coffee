class @window.ServerPoller
  constructor: (poll_url)->
    @poll_url = poll_url
    @timeout_id = 0
    window.server_poller = {} unless window.server_poller
  poll: ->
    if @poll_url
      @clear_poller()
      window.server_poller[@poll_url] = setTimeout (=> @request()), 3000
  request: ->
    $.get(@poll_url)
  clear_poller: ->
    if window.server_poller[@poll_url]
      clearTimeout(window.server_poller[@poll_url])

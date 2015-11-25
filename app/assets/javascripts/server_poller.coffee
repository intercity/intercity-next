class @window.ServerPoller
  constructor: (poll_url)->
    @poll_url = poll_url
    @timeout_id = 0
  poll: ->
    if @poll_url
      @clear_poller()
      window.server_poller = setTimeout (=> @request()), 3000
  request: ->
    $.get(@poll_url)
  clear_poller: ->
    clearTimeout(window.server_poller)

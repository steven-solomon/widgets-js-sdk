###*
  * Setup window 'message' event handler for listening on iframe message events
  * and carrying out appropriate action.
###
CT.Event.addEventListener window, 'message', (event) ->
  unless CT.Widget.hasOrigin event.origin
    CT.console.log "[Dispatch] Received event from unregistered origin, dropping:", event
    return

  payload = JSON.parse event.data
  widget = CT.Widget.getWidgetByWidgetId payload.widgetId

  unless widget?
    CT.console.log "[Dispatch] Could not find widget with id:", payload.widgetId
    return

  # Other widgets may care about this message
  CT.Widget.sendMessageToAllWidgets payload

  # External components may care about this message
  CT.Event.trigger payload.eventName, payload

  # Some messages require actions to be taken, dispatch them here
  switch payload.eventName
    # TODO Handle use case when iframe is in modal
    when "resize"
      {height} = payload.eventData
      if height?
        widget.setHeight height
      else
        CT.console.log "[Dispatch] Received 'resize' event with no 'height'", payload
    when "modal"
      {url} = payload.eventData
      if url?
        CT.Modal.showWithWidgetUrl url
      else
        CT.console.log "[Dispatch] Received 'modal' event with no 'url'", payload
    when "navigate"
      {url} = payload.eventData
      if url?
        window.open payload.eventData.url, "_blank"
      else
        CT.console.log "[Dispatch] Received 'navigate' event with no 'url'", payload
    else
      CT.console.log "[Dispatch] Received event '#{payload.eventName}'", payload
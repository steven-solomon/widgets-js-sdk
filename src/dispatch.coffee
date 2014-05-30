###*
  * Setup window 'message' event handler for listening on iframe message events
  * and carrying out generic events not specific to particular widgets, like
  * navigating to a url
  *
  * For widget-specific events like 'resize', check out the Widget class in the
  * CT.Widget module.
###

CT.Event.addEventListener window, 'message', (event) ->
  unless CT.Widget.hasOrigin event.origin
    CT.console.log "[Dispatch] Received event from unregistered origin, dropping:", event
    return

  payload = JSON.parse event.data

  # External components may care about this message
  CT.Event.trigger payload.eventName, payload

  # Some messages require actions to be taken, dispatch them here
  switch payload.eventName
    when "modal:open"
      {widgetId, src, width} = payload.eventData
      if src?
        CT.console.log "[Dispatch] Received 'modal:open' event, opening modal with data:", payload.eventData

        CT.Modal.show
          id: widgetId ? 0
          src: src
          width: width
      else
        CT.console.log "[Dispatch] Received 'modal:open' event with no 'src' eventData properties", payload
    when "modal:close"
      CT.Modal.hide()
    when "navigate"
      {url} = payload.eventData
      if url?
        CT.console.log "[Dispatch] Received 'navigate' event, opening url:", url

        window.open url, "_blank"
      else
        CT.console.log "[Dispatch] Received 'navigate' event with no 'url'", payload
    else
      # Nothing special

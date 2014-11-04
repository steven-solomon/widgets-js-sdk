###*
  * Setup window 'message' event handler for listening on iframe message events
  * and carrying out generic events not specific to particular widgets, like
  * navigating to a url
  *
  * For widget-specific events like 'resize', check out the Widget class in the
  * CT.Widget module.
###
((CT) ->

  class WindowFacade
    constructor: (@window) ->

    displayExternalURL: (url) =>
      windowReference = @window.open url, '_blank'
      @window.location.href = url unless windowReference?

  windowFacade = new WindowFacade(window);

  ###*
   * Given an object and a path to a deep property, return value of property.
   * Used by 'host:request' event to retrieve arbitrary property on the parent window.
   *
   * @param  {Object} obj  Object to traverse
   * @param  {String} path Path to deep property
   * @return {[type]}      Value of deep property
  ###
  deepFind = (obj, path) ->
    paths = path.split '.'
    current = obj
    i = 0
    while i < paths.length
      unless current[paths[i]]?
        return `undefined`
      else
        current = current[paths[i]]
      ++i
    return current


  CT.$(window).on 'message', (event) ->
    event = event.originalEvent

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

          windowFacade.displayExternalURL url
        else
          CT.console.log "[Dispatch] Received 'navigate' event with no 'url'", payload
      when "host:request"
        {prop} = payload.eventData
        if prop?
          CT.console.log "[Dispatch] Received 'host:request' event with property:", prop
          propValue = deepFind window, prop

          # Create payload to send with value back to widget
          delete payload.direction
          payload.eventName = 'host:response'
          payload.eventData.value = propValue

          # Send payload with value back to widget
          {widgetId} = payload
          widget = CT.Widget.getWidgetByWidgetId widgetId
          widget.sendMessage payload

          CT.console.log "[Dispatch] Sending 'host:response' event to widget #{widgetId} with payload:", payload.eventData
        else
          CT.console.log "[Dispatch] Received 'host:request' event with no 'prop'", payload
      else
        # Nothing special
)(window.CrowdTwist)
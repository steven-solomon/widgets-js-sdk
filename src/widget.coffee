###*
  * Utility functions for creating and manipulating iframes
###
((CT) ->
  unless CT?
    console.log "Error: Could not find global CT namespace!"
    return 0


  ###*
  * Class representing a widget
  ###
  class Widget
    constructor: ({@src, id}) ->
      @id = parseInt id, 10

      # Enforce trailing slash for browser consistency
      @src += "/" if @src.charAt(@src.length - 1) isnt "/"
      @origin = @src.match(CT.Widget._originRegex)[0]

      @el = document.createElement "iframe"
      @el.setAttribute "frameborder", 0
      @el.setAttribute "scrolling", "no"
      @el.setAttribute "data-widget-id", @id
      @el.setAttribute "src", @src
      @el.style.width = "100%";

      @_attachListeners()

    ###*
    * Called during widget initialization, responsible for attaching event handler to
    * window.postMessage and reacting to widget events like 'resize'.
    *
    * For widget-independent event handling, check out the dispatch module.
    *###
    _attachListeners: ->
      CT.Event.addEventListener window, 'message', (event) =>
        unless CT.Widget.hasOrigin event.origin
          CT.console.log "[Widget #{@id}] Received event from unregistered origin, dropping:", event
          return

        payload = JSON.parse event.data
        if @id is payload.widgetId
          switch payload.eventName
            when 'resize'
              {height} = payload.eventData
              if height?
                @setHeight height
              else
                CT.console.log "[Widget #{@id}] Received 'resize' event with no 'height'", payload
            else
              # Nothing to do for specific widget

        @sendMessage payload

    setHeight: (height) ->
      @el.style.height = height + "px"

    ###*
    * Does `postMessage` on the iframe (@el) with given payload
    *
    * @param {Object} payload Contains info such as eventName and eventData
    *
    * Payload object format:
    *
    *   {
    *     eventName: 'name-of-event',
    *     eventData: {
    *       someData: 1,
    *       otherData: true
    *     },
    *     widgetId: 6
    *   }
    ###
    sendMessage: (payload) ->
      payload = JSON.stringify payload unless typeof payload is "string"
      @el.contentWindow.postMessage payload, window.location.origin


  CT.Widget =
    _widgets: []
    _originRegex: /((http(s)?:)?\/\/[^\/?&]+)/

    ###*
      * Converts a widget tag DOM element into an iframe DOM element.
      * Used during initial bootstrapping of a client page.
      *
      * Sample structure of a widget tag:
      *
      * <div class="ct-widget" data-widget-id="1" data-src="http://rewards.crowdtwist.com/widget/sign-up/1"></div>
      *
      * @param {DOMElement} widgetTag A DOM element representing a widget tag.
    ###
    replaceTagWithWidget: (widgetTag) ->
      id = parseInt widgetTag.getAttribute('data-widget-id'), 10
      src = widgetTag.getAttribute 'data-src'

      if @getWidgetByWidgetId(id)?
        CT.console.group "Error"
        CT.console.log "Widget tags with widget id", id, "already exist!"
        CT.console.log "Will not convert the following widget tag:", widgetTag
        CT.console.groupEnd()
        return

      widget = new Widget
        id: id
        src: src

      @_widgets.push widget

      widgetTag.parentNode.replaceChild widget.el, widgetTag
      CT.console.log "Replaced tag", widgetTag, "with widget", widget

    ###*
    * Checks if any registered widgets in CT.Widget._widgets have given origin
    *
    * @param  {String}  origin The origin url string
    * @return {Boolean}        If iframe with given origin has been registered
    ###
    hasOrigin: (origin) ->
      hasOrigin = false
      for widget in @_widgets
        hasOrigin = true if origin.indexOf(widget.origin) isnt -1
      return hasOrigin

    ###*
    * Returns the registered widget with id `widgetId`
    *
    * @param  {Number} widgetId The id of the widget
    * @return {Widget} The      Registered widget instance
    ###
    getWidgetByWidgetId: (widgetId) ->
      widgetId = parseInt widgetId, 10
      for widget in @_widgets
        return widget if widget.id is widgetId

)(window.CT)
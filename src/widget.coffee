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

      CT.Event.addEventListener window, 'message', @_onMessage

    ###*
    * Called during widget initialization, responsible for attaching event handler to
    * window.postMessage and reacting to widget events like 'resize'.
    *
    * For widget-independent event handling, check out the dispatch module.
    *###
    _onMessage: (event) =>
      unless CT.Widget.hasOrigin event.origin
        CT.console.log "[Widget #{@id}] Received event from unregistered origin, dropping:", event
        return

      payload = JSON.parse event.data
      if @id is parseInt payload.widgetId, 10
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

      CT.console.log "[Widget #{@id}] Received event '#{payload.eventName}' from widget '#{payload.widgetId}' with data:", payload.eventData

    ###*
     * Unregisters the #_onMessage 'message' handler
    ###
    _removeListeners: ->
      CT.Event.removeEventListener window, 'message', @_onMessage


    setHeight: (height) ->
      height = parseInt height, 10
      @el.style.height = height + "px"

      # If widget is contained in modal, set the
      # modal container height as well
      CT.Modal.setHeight height if @el.parentNode is CT.Modal._modal.el

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
      @el.contentWindow.postMessage payload, '*'


  CT.Widget =
    _widgets: []
    _originRegex: /((http(s)?:)?\/\/[^\/?&]+)/

    ###*
     * Given a widget id and src, creates a new Widget and adds it to
     * the list of _widgets
     *
     * @param {Number} id   The widget id
     * @param {String} src  Tne widget url
    ###
    addWidget: ({id, src}) ->
      widget = new Widget
        id: id ? 0
        src: src

      @_widgets.push widget
      return widget

    ###*
     * Removes a Widget object from _widgets, unregistering listeners along the way
     *
     * @param  {Widget} widget The Widget object to remove
    ###
    removeWidget: (widget) ->
      widget._removeListeners()
      index = @_widgets.indexOf widget
      @_widgets.splice index, 1 if index > -1

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

      widget = @addWidget
        id: id
        src: src

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

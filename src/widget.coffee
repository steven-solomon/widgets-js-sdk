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
    constructor: ({@src, id, scroll}) ->
      @id = parseInt id, 10
      scroll ?= false

      # Enforce trailing slash for browser consistency
      @src += "/" if @src.charAt(@src.length - 1) isnt "/"
      @origin = @src.match(CT.Widget._originRegex)[0]

      @el = document.createElement "iframe"
      @$el = CT.$(@el)

      @$el.attr
        "frameborder": 0
        "scrolling": if scroll then "auto" else "no"
        "data-widget-id": @id
        "src": @src

      @$el.css
        opacity: "0"
        width: "100%"
        height: "0"

      CT.$(window).on 'message', @_onMessage

    ###*
    * Called during widget initialization, responsible for attaching event handler to
    * window.postMessage and reacting to widget events like 'resize'.
    *
    * For widget-independent event handling, check out the dispatch module.
    *###
    _onMessage: (event) =>
      event = event.originalEvent

      unless CT.Widget.hasOrigin event.origin
        CT.console.log "[Widget #{@id}] Received event from unregistered origin, dropping:", event
        return

      payload = JSON.parse event.data
      if @id is parseInt payload.widgetId, 10
        CT.console.log "[Widget #{@id}] Received event '#{payload.eventName}' with data:", payload.eventData

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

    ###*
     * Unregisters the #_onMessage 'message' handler
    ###
    _removeListeners: ->
      CT.$(window).off 'message', @_onMessage

    ###*
     * Helper function that returns if widget is being shown in a modal
     * @return {Boolean} Is widget in a modal?
    ###
    inModal: ->
      @el.parentNode is CT.Modal._modal.iframeContainer

    setHeight: (height) ->
      height = parseInt height, 10

      if height > ((windowHeight = CT.$(window).height()) - 100)
        if @inModal()
          height = windowHeight - 100
          CT.Modal._modal.$el.css top: 0
      else
        CT.Modal._modal.$el.css top: CT.Modal._modal.containerStyle.top if @inModal()

      if height is 0
        @$el.height(0).fadeTo 'fast', 0
      else
        if @$el.height() is 0
          @$el.height(height).delay(200).fadeTo 'slow', 1
          if @inModal()
            CT.Modal._modal.$el.css('zIndex', '10000').fadeTo 'slow', 1
        else
          @$el.height height

      if @inModal() and (/iPhone|iPod|iPad|Android|BlackBerry/).test navigator.userAgent
        CT.Modal._modal.$iframeContainer.height height

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
     * @param {Number}  id      The widget id
     * @param {String}  src     The widget url
     * @param {Boolean} scroll  Whether the widget container should scroll
    ###
    addWidget: ({id, src, scroll}) ->
      widget = new Widget
        id: id ? 0
        src: src
        scroll: scroll

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

      CT.$(widgetTag).replaceWith widget.el
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

)(window.CrowdTwist)

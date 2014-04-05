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

    ###*
    * Does a `postMessage` on all registered widget iframes with given payload
    *
    * @param {Object} payload Contains info such as eventName and eventData
    ###
    sendMessageToAllWidgets: (payload) ->
      widget.sendMessage payload for widget in @_widgets
)(window.CT)
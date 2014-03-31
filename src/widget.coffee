###*
  * Utility functions for creating and manipulating iframes
###
((CT) ->
  unless CT?
    console.log "Error: Could not find global CT namespace!"
    return 0


  ###*
  * Class representing a widget iframe
  ###
  class Widget
    constructor: ({@src, height}) ->
      # Enforce trailing slash for browser consistency
      @src += "/" if @src.charAt(@src.length - 1) isnt "/"
      @origin = @src.match(CT.Widget._originRegex)[0]

      @el = document.createElement "iframe"
      @el.setAttribute "frameborder", 0
      @el.setAttribute "scrolling", "no"
      @el.setAttribute "src", @src
      @el.style.width = "100%";
      @el.style.height = height + "px" if height?


  CT.Widget =
    _widgets: []
    _originRegex: /(http(s)?:\/\/[^\/?&]+)/

    ###*
      * Converts a widget tag DOM element into an iframe DOM element.
      * Used during initial bootstrapping of a client page.
      *
      * Sample structure of a widget tag:
      *
      * <div class="ct-widget" data-src="http://rewards.crowdtwist.com/widget/sign-up/1"></div>
      *
      * @param {DOMElement} widgetTag A DOM element representing a widget tag.
    ###
    _replaceTagWithWidget: (widgetTag) ->
      src = widgetTag.getAttribute 'data-src'
      height = widgetTag.getAttribute 'data-height'

      widget = new Widget
        src: src
        height: height

      CT.Widget._widgets.push widget

      widgetTag.parentNode.replaceChild widget.el, widgetTag
      CT.console.log "Replaced tag", widgetTag, "with iframe pointing to", src


)(window.CT)
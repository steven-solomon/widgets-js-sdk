###*
  * Utility functions for showing and hiding modals
###
((CT) ->
  unless CT?
    console.log "Error: Could not find global CT namespace!"
    return 0


  ###*
  * Class that represents the modal container. Instantiated by CT.Widget.initModalContainer()
  *###
  class Modal
    containerStyle:
      display: 'none'
      zIndex: '100000'
      margin: 'auto'
      width: '90%'
      position: 'fixed'
      top: '100px'
      right: '0'
      bottom: '0'
      left: '0'

    closeButtonStyle:
      float: 'right'
      background: 'none'
      border: 'none'
      color: '#ffffff'
      fontSize: '20px'
      outline: 'none'
      cursor: 'pointer'

    backgroundStyle:
      display: 'none'
      position: 'fixed'
      top: '0'
      left: '0'
      width: '100%'
      height: '100%'
      zIndex: '1000'
      backgroundColor: '#000000'
      opacity: '0.7'
      filter: 'alpha(opacity=70)'

    constructor: ->
      @el = document.createElement "div"
      @el.setAttribute "id", "ct-modal"

      @closeButton = document.createElement "button"
      CT.Event.addEventListener @closeButton, "click", => @hide()

      @background = document.createElement "div"

      @_initStyles()

      @el.appendChild @closeButton

    removeCurrentWidget: =>
      @el.removeChild @widget.el
      CT.Widget.removeWidget @widget

    ###*
    * Shows the modal and initializes a new widget inside the modal
    *
    * @param {Number} id  The id of the widget
    * @param {String} src The url of the widget to display in the modal
    *
    * @example
    *   CT.Modal.show
    *     id: 0
    *     src: 'http://rewards.crowdtwist.com/widgets/t/account-overview/0'
    *###
    show: ({id, src}) ->
      @removeCurrentWidget() if CT.Widget.getWidgetByWidgetId(@widget?.id)?.inModal()

      @widget = CT.Widget.addWidget
        id: id ? 0
        src: src

      @el.appendChild @widget.el
      CT.$(@background).fadeIn 'slow'

      # Set responsive mode when displaying modal
      CT._metaTag.setAttribute 'content', "width=device-width, height=device-height, initial-scale=1, maximum-scale=1, user-scalable=no"

      return this

    ###*
    * Hides the modal
    *###
    hide: ->
      CT.$(@background).fadeOut 'slow'
      CT.$(@el).fadeOut 'slow', =>
        # Revert back to default viewport when hiding modal
        CT._metaTag.setAttribute 'content', CT._metaTagContent

        @removeCurrentWidget() if CT.Widget.getWidgetByWidgetId(@widget?.id)?

      return this

    setWidth: (width) ->
      width = parseInt width, 10
      @el.style.maxWidth = width + "px"

    ###*
     * Called by CT.Widget when a resize event comes in with
     * a positive height.
     *
     * This transitions the modal from a loading state to
     * an active, visible state.
    ###
    hasLoaded: ->
      CT.$(@el).fadeIn 'slow'

    ###*
    * Called from the constructor to apply styling to the modal and related elements
    *###
    _initStyles: ->
      # Modal container
      @el.setAttribute "id", "ct-modal"
      @el.style[attribute] = value for attribute, value of @containerStyle

      # Close button
      @closeButton.innerHTML = "&#10005;"
      @closeButton.style[attribute] = value for attribute, value of @closeButtonStyle

      # Modal dimmed background
      @background.setAttribute "id", "ct-modal-background"
      @background.style[attribute] = value for attribute, value of @backgroundStyle


  CT.Modal =
    ###*
    * Unless already exists, create and insert element into host page
    * that will contain the modal content. Also create element for the
    * dimmed background.
    *
    * Modal is identified by the id: ct-modal
    ###
    initModalContainer: ->
      if document.getElementById("ct-modal")?
        CT.console.log "Modal container #ct-modal already exists!"
        return

      @_modal = new Modal()
      document.body.insertBefore @_modal.background, document.body.firstChild
      document.body.insertBefore @_modal.el, document.body.firstChild

    setWidth: (width) ->
      width = parseInt width, 10
      @_modal.setWidth width

    show: ({id, src, width}) ->
      unless @_modal?
        CT.console.log "Modal not initialized!"
        return

      @_modal.show
        id: id
        src: src

      @setWidth width if width?

    hasLoaded: ->
      @_modal.hasLoaded()

    hide: ->
      unless @_modal?
        CT.console.log "Modal not initialized!"
        return

      @_modal.hide()


)(window.CT)

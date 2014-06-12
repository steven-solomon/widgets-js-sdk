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
      top: '10%'
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
      @$el = CT.$(@el)

      @$el.attr "id", "ct-modal"

      @closeButton = document.createElement "button"
      @$closeButton = CT.$(@closeButton)
      @$closeButton.click => @hide()

      @background = document.createElement "div"
      @$background = CT.$(@background)

      @_initStyles()

      @$el.append @closeButton

    removeCurrentWidget: =>
      @widget.$el.remove()
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

      @$el.append @widget.el
      @$background.fadeIn 'slow'

      # Set responsive mode when displaying modal
      CT._metaTag.setAttribute 'content', "width=device-width, height=device-height, initial-scale=1, maximum-scale=1, user-scalable=no"

      return this

    ###*
    * Hides the modal
    *###
    hide: ->
      @$background.fadeOut 'slow'
      @$el.fadeOut 'slow', =>
        # Revert back to default viewport when hiding modal
        CT._metaTag.setAttribute 'content', CT._metaTagContent

        @removeCurrentWidget() if CT.Widget.getWidgetByWidgetId(@widget?.id)?

      return this

    setWidth: (width) ->
      width = parseInt width, 10
      @$el.css 'maxWidth', width

    setHeight: (height) ->
      height = parseInt height, 10
      @$el.height height

    ###*
     * Called by CT.Widget when a resize event comes in with
     * a positive height.
     *
     * This transitions the modal from a loading state to
     * an active, visible state.
    ###
    hasLoaded: ->
      @$el.fadeIn 'slow'

    ###*
    * Called from the constructor to apply styling to the modal and related elements
    *###
    _initStyles: ->
      # Modal container
      @$el.attr "id", "ct-modal"
      @$el.css attribute, value for attribute, value of @containerStyle

      # For mobile devices, we don't want a top margin on the modal
      if (/iPhone|iPod|iPad|Android|BlackBerry/).test navigator.userAgent
        @$el.css
          top: 0

      # Close button
      @$closeButton.html "&#10005;"
      @$closeButton.css attribute, value for attribute, value of @closeButtonStyle

      # Modal dimmed background
      @$background.attr "id", "ct-modal-background"
      @$background.css attribute, value for attribute, value of @backgroundStyle


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
      CT.$('body').prepend @_modal.background
      CT.$('body').prepend @_modal.el

    setWidth: (width) ->
      width = parseInt width, 10
      @_modal.setWidth width

    setHeight: (height) ->
      height = parseInt height, 10
      @_modal.setHeight height

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

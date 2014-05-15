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
      top: '0'
      right: '0'
      bottom: '0'
      left: '0'
      boxShadow: '0px 19px 33px -11px rgba(0, 0, 0, 0.75)'

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
      if @widget?
        @el.removeChild @widget.el
        CT.Widget.removeWidget @widget

      @widget = CT.Widget.addWidget
        id: id
        src: src
      @el.appendChild @widget.el

      @el.style.display = ""
      @background.style.display = ""
      return this

    ###*
    * Hides the modal
    *###
    hide: ->
      @el.style.display = "none"
      @background.style.display = "none"
      return this

    setWidth: (width) ->
      width = parseInt width, 10
      @el.style.maxWidth = width + "px"

    setHeight: (height) ->
      height = parseInt height, 10
      @el.style.height = height + "px"

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

    hide: ->
      unless @_modal?
        CT.console.log "Modal not initialized!"
        return

      @_modal.hide()


)(window.CT)
###*
  * Utility functions for showing and hiding modals
###
((CT) ->
  unless CT?
    console.log "Error: Could not find global CT namespace!"
    return 0


  ###*
  * Class that represents the modal container. Instantiated by CT.Widget._initModalContainer()
  *###
  class Modal
    constructor: ->
      @el = document.createElement "div"
      @el.setAttribute "id", "ct-modal"

      @closeButton = document.createElement "button"
      CT.Event._addEventListener @closeButton, "click", =>
        @hide()

      @iframe = document.createElement "iframe"
      @background = document.createElement "div"

      @_applyStyles()

      @el.appendChild @closeButton
      @el.appendChild @iframe

    ###*
    * Shows the modal and sets the iframe to the specified url
    *
    * @param {String} url The url of the widget to display in the modal
    *###
    showWithWidgetUrl: (url) ->
      @iframe.setAttribute "src", url
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

    ###*
    * Called from the constructor to apply styling to the modal and related elements
    *###
    _applyStyles: ->
      # Modal container div styling
      @el.setAttribute "id", "ct-modal"
      @el.style.display = "none"
      @el.style.zIndex = "100000"
      @el.style.margin = "auto"
      @el.style.width = "90%"
      @el.style.position = "fixed"
      @el.style.top = "0"
      @el.style.right = "0"
      @el.style.bottom = "0"
      @el.style.left = "0"
      @el.style.backgroundColor = "#414141"
      @el.style.boxShadow = "0px 19px 33px -11px rgba(0, 0, 0, 0.75)"

      # Close button styling
      @closeButton.innerHTML = "&#10005;"
      @closeButton.style.float = "right"
      @closeButton.style.background = "none"
      @closeButton.style.border = "none"
      @closeButton.style.color = "#fff"
      @closeButton.style.fontSize = "20px"
      @closeButton.style.cursor = "pointer"

      # Modal iframe styling
      @iframe.setAttribute "frameborder", 0
      @iframe.setAttribute "scrolling", "no"
      @iframe.style.width = "100%"
      @iframe.style.borderTop = "2px solid #000"

      # Modal dimmed background styling
      @background.setAttribute "id", "ct-modal-background"
      @background.style.display = "none"
      @background.style.position = "fixed"
      @background.style.top = "0"
      @background.style.left = "0"
      @background.style.width = "100%"
      @background.style.height = "100%"
      @background.style.zIndex = "1000"
      @background.style.background = "#000"
      @background.style.opacity = "0.7"
      @background.style.filter = "alpha(opacity=70)"


  CT.Modal =
    ###*
    * Unless already exists, create and insert element into host page
    * that will contain the modal content. Also create element for the
    * dimmed background.
    *
    * Modal is identified by the id: ct-modal
    ###
    _initModalContainer: ->
      if document.getElementById("ct-modal")?
        CT.console.log "Modal container #ct-modal already exists!"
        return

      @_modal = new Modal()
      document.body.insertBefore @_modal.background, document.body.firstChild
      document.body.insertBefore @_modal.el, document.body.firstChild

    showWithWidgetUrl: (url) ->
      unless @_modal?
        CT.console.log "Modal not initialized!"
        return

      @_modal.showWithWidgetUrl url

    hide: ->
      unless @_modal?
        CT.console.log "Modal not initialized!"
        return

      @_modal.hide()


)(window.CT)
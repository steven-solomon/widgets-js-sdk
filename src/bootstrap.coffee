###*
 * This is the entry point of the SDK where it listens on DOM ready
 * and converts all widget tags to iframes
###

CT.console.group "Bootstrap"
CT.console.time "Bootstrapped in"
CT.console.time "DOM loaded"

CT.Event.ready ->
  CT.console.timeEnd "DOM loaded"

  CT.console.log "Initializing modal container"
  CT.Modal.initModalContainer()

  widgetTags = document.querySelectorAll "[class=ct-widget]"

  CT.console.log "Found", widgetTags.length, "widget tag(s)"
  CT.console.group "Tag replacement"

  CT.Widget.replaceTagWithWidget widgetTag for widgetTag in widgetTags

  CT.console.groupEnd()
  CT.console.groupEnd()

  CT.console.timeEnd "Bootstrapped in"
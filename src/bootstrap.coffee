###*
 * This is the entry point of the SDK where it listens on DOM ready
 * and converts all widget tags to iframes
###

CT.console.group "Bootstrap"
CT.console.time "Bootstrapped in"
CT.console.time "DOM loaded"

CT.Event._ready ->
  CT.console.timeEnd "DOM loaded"

  widgetTags = document.querySelectorAll "[class=ct-widget]"

  CT.console.log "Found", widgetTags.length, "widget tag(s)"
  CT.console.group "Tag replacement"

  CT.Widget._replaceTagWithWidget widgetTag for widgetTag in widgetTags

  CT.console.groupEnd()
  CT.console.groupEnd()

  CT.console.timeEnd "Bootstrapped in"
###*
 * Shims around console for enhanced logging on supported browsers as well as proper fallback on IE
###
((CT) ->
  unless CT?
    console.log "Error: Could not find global CT namespace!"
    return 0

  DEBUG = !!window.CT_DEBUG
  LOG_PREFIX = "(widgets)"
  IS_MODERN = typeof console.time is "function"

  CT.console =
    log: ->
      if DEBUG
        args = Array.prototype.slice.apply arguments

        if IS_MODERN
          args.unshift "color: #bc43a7; font-weight: bold;"
          args.unshift "%c" + LOG_PREFIX
          console.log.apply console, args
        else
          console.log args.join ' '

    group: (label) ->
      if DEBUG
        label = LOG_PREFIX + " " + label
        if typeof console.group is "function"
          console.group label
        else
          console.log label

    groupEnd: ->
      console.groupEnd?()

    time: (label) ->
      if DEBUG
        console.time?(LOG_PREFIX + " " + label)

    timeEnd: (label) ->
      if DEBUG
        console.timeEnd?(LOG_PREFIX + " " + label)
)(window.CrowdTwist)
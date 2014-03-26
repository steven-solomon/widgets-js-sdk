###*
 * Event bus for pubsub communications between host page and widgets.
 *
 * Methods:
 *   subscribe(eventName, callback)
 *   unsubscribe(eventName, callback)
###
((CT) ->
  unless CT?
    console.log "Error: Could not find global CT namespace!"
    return 0


  ###*
   * Optimized dispatch function borrowed from Backbone.Events for
   * triggering events.
   *
   * @param  {Array} events  Array of event objects
   * @param  {Array} args    Arguments to pass to the event callbacks
  ###
  triggerEvents = (events, args) ->
    i = -1
    l = events.length
    a1 = args[0]
    a2 = args[1]
    a3 = args[2]

    switch args.length
      when 0
        (ev = events[i]).callback.call null while ++i < l
        return
      when 1
        (ev = events[i]).callback.call null, a1 while ++i < l
        return
      when 2
        (ev = events[i]).callback.call null, a1, a2 while ++i < l
        return
      when 3
        (ev = events[i]).callback.call null, a1, a2, a3 while ++i < l
        return
      else
        (ev = events[i]).callback.apply null, args while ++i < l
        return


  CT.Event =
    ###*
    * Internal shim for default browser addEventListener with IE 8 fallback
    ###
    _addEventListener: (el, name, handler) ->
      if typeof el.addEventListener is "function"
        el.addEventListener name, handler
      else
        el.attachEvent "on" + name, handler

    ###*
    * Internal shim for default browser removeEventListener with IE 8 fallback
    ###
    _removeEventListener: (el, name, handler) ->
      if typeof el.removeEventListener is "function"
        el.removeEventListener name, handler
      else
        el.detachEvent "on" + name, handler

    ###*
    * Executes a function when the DOM is fully loaded
    ###
    _ready: (handler) ->
      if typeof document.addEventListener is "function"
        document.addEventListener "DOMContentLoaded", handler
      else
        document.attachEvent "onreadystatechange", ->
          handler() if document.readyState is "complete"

    ###*
     * Private function to be used by Widget SDK to trigger certain events
     *
     * @param  {String} name        Name of event to trigger
     * @param  {Array}  arguments   Variable list of arguments to pass to callbacks
    ###
    _trigger: (name) ->
      return this unless @_events?

      args = Array.prototype.slice.call arguments, 1
      events = @_events[name]
      if events
        triggerEvents(events, args)
        CT.console.log "triggered event '#{name}' with arguments:", args

      return this

    ###*
     * Bind an event to a callback
     *
     * @param  {String}   name     Name of event
     * @param  {Function} callback The callback to bind to the event
    ###
    subscribe: (name, callback) ->
      return this unless callback?

      @_events ?= {}
      events = @_events[name] ?= []
      events.push
        callback: callback
      return this

    ###*
     * Remove one or many callbacks. If `callback` is null, removes all
     * callbacks for the event. If `name` is null, removes all callbacks
     * across all events.
     *
     * @param  {String}   name     Name of event
     * @param  {Function} callback The callback to unsubscribe
    ###
    unsubscribe: (name, callback) ->
      unless name? or callback?
        @_events = null
        return this

      names = if name then [name] else [name for name of @_events]
      for name in names
        if events = @_events[name]
          @_events[name] = retain = []

          if callback?
            for event in events
              retain.push event if callback isnt event.callback

          delete @_events[name] unless retain.length

      return this
)(window.CT)
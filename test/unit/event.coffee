describe 'CT.Event', ->
  {Event} = window.CT

  it 'should exist', ->
    expect(Event).to.exist

  it 'should contain properties and methods', ->
    expect(Event).to.include.keys [
      'trigger'
      'subscribe'
      'unsubscribe'
    ]

  it 'should handle subscriptions', ->
    cb = sinon.spy()
    Event.subscribe 'testEvent', cb

    expect(Event._events).to.include.keys 'testEvent'
    expect(Event._events.testEvent.length).to.equal 1
    expect(Event._events.testEvent[0].callback).to.equal cb

    Event.unsubscribe()

    expect(Event._events).to.not.exist

  it 'should trigger event and execute appropriate callback', ->
    cb = sinon.spy()
    data =
      name: 'someEvent'
      coll: [1,2,3]

    Event.subscribe 'testEvent', cb
    Event.trigger 'testEvent', data

    expect(cb).to.be.calledOnce
    expect(cb).to.be.calledWith data

    Event.unsubscribe 'testEvent'

    expect(Event._events).to.be.empty

  it 'should execute multiple callbacks', ->
    cb1 = sinon.spy()
    cb2 = sinon.spy()
    data = "Hello World"

    Event.subscribe 'testEvent', cb1
    Event.subscribe 'testEvent', cb2

    Event.trigger 'testEvent', data
    expect(cb1).to.be.calledOnce
    expect(cb1).to.be.calledWith data
    expect(cb2).to.be.calledOnce
    expect(cb2).to.be.calledWith data

    Event.unsubscribe()

    expect(Event._events).to.not.exist

  it 'should not execute callbacks for untriggered events', ->
    cb1 = sinon.spy()
    cb2 = sinon.spy()

    Event.subscribe 'activeEvent', cb1
    Event.subscribe 'inactiveEvent', cb2
    Event.trigger 'activeEvent'

    expect(cb1).to.be.calledOnce
    expect(cb2).to.not.be.called

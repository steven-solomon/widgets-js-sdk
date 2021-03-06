describe "CT Dispatch's Internal Window Facade", ->
  {_WindowFacade_} = window.CrowdTwist
  KNOWN_URL = 'http://www.crowdtwist.com'

  xdescribe 'displayExternalURL', ->
    fakeWindow  =
      open: (url, target) ->
    openSpy = null
    windowFacade = null

    before ->
      openSpy = sinon.stub fakeWindow, 'open', ->
        return {}
      windowFacade = new _WindowFacade_(fakeWindow)

    after ->
      openSpy.reset()
      windowFacade = null

    xit 'should call window.open', ->
      windowFacade.displayExternalURL(KNOWN_URL)

      expect(openSpy).to.be.calledOnce

    xit 'should call window.open with correct arguments', ->
      windowFacade.displayExternalURL(KNOWN_URL)

      expect(openSpy).to.be.calledWith KNOWN_URL, '_blank'

  xdescribe 'displayExternalURL when window.open returns null', ->
    fakeWindow  =
        open: (url, target) ->
        location:
          href: null
    openStub = null
    windowFacade = null

    before ->
      openStub = sinon.stub fakeWindow, 'open', ->
        return undefined
      windowFacade = new _WindowFacade_(fakeWindow)

    after ->
      openStub.reset()

    xit 'should call window.location', ->
      windowFacade.displayExternalURL(KNOWN_URL)

      expect(fakeWindow.location.href).to.be.equal(KNOWN_URL)

    xit 'should call window.location with url', ->
      windowFacade.displayExternalURL(KNOWN_URL)

      expect(fakeWindow.location.href).to.be.equal(KNOWN_URL)




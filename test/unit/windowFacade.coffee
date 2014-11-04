describe 'CT Dispatch\'s Internal Window Facade', ->
  {_WindowFacade_} = window.CrowdTwist
  KNOWN_URL = 'http://www.crowdtwist.com'

  describe 'displayExternalURL', ->
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

    it 'should call window.open', ->
      windowFacade.displayExternalURL(KNOWN_URL)

      expect(openSpy).to.be.calledOnce

    it 'should call window.open with correct arguments', ->
      windowFacade.displayExternalURL(KNOWN_URL)

      expect(openSpy).to.be.calledWith KNOWN_URL, '_blank'

  describe 'displayExternalURL when window.open returns null', ->
    fakeWindow  =
        open: (url, target) ->
        location: (url) ->
    openStub = null
    locationSpy = null
    windowFacade = null

    before ->
      openStub = sinon.stub fakeWindow, 'open', ->
        return undefined
      locationSpy = sinon.spy(fakeWindow, 'location')
      windowFacade = new _WindowFacade_(fakeWindow)

    after ->
      openStub.reset()
      locationSpy.reset()

    it 'should call window.location', ->
      windowFacade.displayExternalURL(KNOWN_URL)

      expect(locationSpy).to.be.calledOnce

    it 'should call window.location with url', ->
      windowFacade.displayExternalURL(KNOWN_URL)

      expect(locationSpy).to.be.calledWith KNOWN_URL




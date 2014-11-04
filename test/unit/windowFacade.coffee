describe 'CT Dispatch\'s Internal Window Facade', ->
  {WindowFacade} = window.CrowdTwist
  KNOWN_URL = 'http://www.crowdtwist.com'

  describe 'displayExternalURL', ->
    fakeWindow  =
      open: (url, target) ->
    openSpy = null
    windowFacade = null

    before ->
      openSpy = sinon.stub fakeWindow, 'open', ->
        return {}
      windowFacade = new WindowFacade(fakeWindow)

    after ->
      openSpy.reset()
      windowFacade = null

    it 'should call window.open', ->
      windowFacade.displayExternalURL(KNOWN_URL)

      expect(openSpy).to.be.calledOnce

    it 'should call window.open with desired arguments', ->
      windowFacade.displayExternalURL(KNOWN_URL)

      expect(openSpy).to.be.calledWith KNOWN_URL, '_blank'

  describe 'displayExternalURL when window.open returns null', ->
    it 'should call window.location', ->
      fakeWindow  =
        open: (url, target) ->
        location: (url) ->
      openStub = sinon.stub fakeWindow, 'open', ->
        return undefined
      locationSpy = sinon.spy(fakeWindow, 'location')
      windowFacade = new WindowFacade(fakeWindow)

      windowFacade.displayExternalURL(KNOWN_URL)

      expect(locationSpy).to.be.calledOnce




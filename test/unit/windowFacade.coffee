describe 'SDK: Dispatch Window Facade', ->
  {WindowFacade} = window.CrowdTwist
  KNOWN_URL = 'http://www.crowdtwist.com'

  describe 'window.open success', ->
    it 'displayExternalURL calls window.open', ->
      fakeWindow  =
        open: (url, target) ->
      openSpy = sinon.stub fakeWindow, 'open', ->
        return {}
      windowFacade = new WindowFacade(fakeWindow)

      windowFacade.displayExternalURL(KNOWN_URL)

      expect(openSpy).to.be.calledOnce

    it 'displayExternalURL calls window.open with desired arguments', ->
      fakeWindow  =
        open: (url, target) ->
      openSpy = sinon.stub fakeWindow, 'open', ->
        return {}
      windowFacade = new WindowFacade(fakeWindow)

      windowFacade.displayExternalURL(KNOWN_URL)

      expect(openSpy).to.be.calledWith KNOWN_URL, '_blank'

  describe 'window.open failure', ->
    it 'displayExternalURL calls window.location when window.open returns undefined', ->
      fakeWindow  =
        open: (url, target) ->
        location: (url) ->
      openStub = sinon.stub fakeWindow, 'open', ->
        return undefined
      locationSpy = sinon.spy(fakeWindow, 'location')
      windowFacade = new WindowFacade(fakeWindow)

      windowFacade.displayExternalURL(KNOWN_URL)

      expect(locationSpy).to.be.calledOnce




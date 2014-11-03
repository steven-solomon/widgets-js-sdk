describe 'SDK: Dispatch Window Facade', ->
  {WindowFacade} = window.CrowdTwist
  KNOWN_URL = 'http://www.crowdtwist.com'

  it 'displayExternalURL calls window.open', ->
    fakeWindow  =
      open: (url, target) ->
    openSpy = sinon.spy(fakeWindow, 'open');
    windowFacade = new WindowFacade(fakeWindow)

    windowFacade.displayExternalURL(KNOWN_URL)

    expect(openSpy).to.be.calledOnce

  it 'displayExternalURL calls window.open with desired arguments', ->
    fakeWindow  =
      open: (url, target) ->
    openSpy = sinon.spy(fakeWindow, 'open');
    windowFacade = new WindowFacade(fakeWindow)

    windowFacade.displayExternalURL(KNOWN_URL)

    expect(openSpy).to.be.calledWith KNOWN_URL, '_blank'

  # it 'foo', ->
  #   locationSpy = sinon.spy(fakeWindow, 'location')
  #   windowFacade = new WindowFacade(fakeWindow)

  #   windowFacade.displayExternalURL(KNOWN_URL)

  #   expect(openSpy).to.be.calledWith KNOWN_URL, '_blank'




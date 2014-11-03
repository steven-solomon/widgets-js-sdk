describe 'SDK: Dispatch Window Facade', ->
  {WindowFacade} = window.CrowdTwist
  KNOWN_URL = 'http://www.crowdtwist.com'
  spyWindow  =
    open: (url, target) ->
  openSpy = null
  windowFacade = null

  before ->
    openSpy = sinon.spy(spyWindow, 'open');
    windowFacade = new WindowFacade(spyWindow)

  after ->
    openSpy.reset()

  it 'displayExternalURL calls window.open', ->
    windowFacade.displayExternalURL(KNOWN_URL)

    expect(openSpy).to.be.calledOnce

  it 'displayExternalURL calls window.open with desired arguments', ->
    windowFacade.displayExternalURL(KNOWN_URL)

    expect(openSpy).to.be.calledWith KNOWN_URL, '_blank'




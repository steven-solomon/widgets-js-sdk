describe 'SDK: Modal', ->
  before ->
    browser.get '/'

  describe 'initModalContainer()', ->
    it 'should initialize modal container', ->
      expect(exists('#ct-modal')).to.eventually.equal true

      modalEl = $('#ct-modal')

      expect(modalEl.isElementPresent(By.css('button'))).to.eventually.equal true

    it 'should initialize modal background', ->
      expect(exists('#ct-modal-background')).to.eventually.equal true

      modalBackgroundEl = $('#ct-modal-background')

      expect(modalBackgroundEl.isDisplayed()).to.eventually.equal false

  describe 'show()', ->
    it 'should display modal with widget url', ->
      exec ->
        CT.Modal.show
          id: 0
          src: '//localhost:3001/widget2.html'

      modalIframeEl = $('#ct-modal iframe')
      expect(modalIframeEl.getAttribute('src')).to.eventually.equal 'http://localhost:3001/widget2.html/'

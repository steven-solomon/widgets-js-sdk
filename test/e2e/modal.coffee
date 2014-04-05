describe 'SDK: Modal', ->
  before ->
    browser.get '/'

  describe 'initModalContainer()', ->
    it 'should initialize modal container', ->
      expect(exists('#ct-modal')).to.eventually.equal true

      modalEl = $('#ct-modal')

      expect(modalEl.isDisplayed()).to.eventually.equal false
      expect(modalEl.isElementPresent(By.css('button'))).to.eventually.equal true
      expect(modalEl.isElementPresent(By.css('iframe'))).to.eventually.equal true

    it 'should initialize modal background', ->
      expect(exists('#ct-modal-background')).to.eventually.equal true

      modalBackgroundEl = $('#ct-modal-background')

      expect(modalBackgroundEl.isDisplayed()).to.eventually.equal false

  describe 'showWithWidgetUrl()', ->
    it 'should display modal with widget url', ->
      exec ->
        CT.Modal.showWithWidgetUrl '//localhost:3001/widget2.html'

      modalEl = $('#ct-modal')
      modalBackgroundEl = $('#ct-modal-background')
      modalIframeEl = $('#ct-modal iframe')

      expect(modalEl.isDisplayed()).to.eventually.equal true
      expect(modalBackgroundEl.isDisplayed()).to.eventually.equal true
      expect(modalIframeEl.getAttribute('src')).to.eventually.equal 'http://localhost:3001/widget2.html'

  describe 'hide()', ->
    it 'should hide modal', ->
      exec ->
        CT.Modal.hide()

      modalEl = $('#ct-modal')
      modalBackgroundEl = $('#ct-modal-background')

      expect(modalEl.isDisplayed()).to.eventually.equal false
      expect(modalBackgroundEl.isDisplayed()).to.eventually.equal false

    it 'should hide modal with button click', ->
      exec ->
        CT.Modal.showWithWidgetUrl '//localhost:3001/widget2.html'

      modalEl = $('#ct-modal')
      modalBackgroundEl = $('#ct-modal-background')
      closeButtonEl = $('#ct-modal button')

      expect(modalEl.isDisplayed()).to.eventually.equal true
      expect(modalBackgroundEl.isDisplayed()).to.eventually.equal true

      closeButtonEl.click()

      expect(modalEl.isDisplayed()).to.eventually.equal false
      expect(modalBackgroundEl.isDisplayed()).to.eventually.equal false
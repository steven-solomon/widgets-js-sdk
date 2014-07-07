describe 'SDK: Widget', ->
  before ->
    browser.get '/'

  describe 'replaceTagWithWidget()', ->
    it 'should replace widget tag with iframe', ->
      expect(exists('iframe[data-widget-id="1"]')).to.eventually.equal true
      expect(exists('iframe[data-widget-id="2"]')).to.eventually.equal true

      iframeEl1 = $('iframe[data-widget-id="1"]')
      iframeEl2 = $('iframe[data-widget-id="2"]')

      expect(iframeEl1.getAttribute('src')).to.eventually.equal 'http://localhost:3001/widget1.html/'
      expect(iframeEl2.getAttribute('src')).to.eventually.equal 'http://localhost:3001/widget2.html/'

  describe 'hasOrigin()', ->
    it 'should return true for a registered origin', ->
      hasOrigin = exec ->
        CT.Widget.hasOrigin 'http://localhost:3001'

      expect(hasOrigin).to.eventually.equal true

    it 'should return false for an unregistered origin', ->
      hasOrigin = exec ->
        CT.Widget.hasOrigin 'http://unregistered.domain.com'

      expect(hasOrigin).to.eventually.equal false

  describe 'getWidgetByWidgetId()', ->
    it 'should return widget with widget id', ->
      widget = exec ->
        CT.Widget.getWidgetByWidgetId 1

      expect(widget).to.eventually.have.property 'id', 1
      expect(widget).to.eventually.have.property 'src', '//localhost:3001/widget1.html/'
      expect(widget).to.eventually.have.property 'origin', '//localhost:3001'
      expect(widget).to.eventually.have.property 'el'

    it 'should return undefined for nonexistent widget id', ->
      widget = exec ->
        CT.Widget.getWidgetByWidgetId -1

      expect(widget).to.eventually.not.exist
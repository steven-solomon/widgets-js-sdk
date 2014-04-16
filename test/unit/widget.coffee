describe 'CT.Widget', ->
  {Widget} = window.CT

  it 'should exist', ->
    expect(Widget).to.exist

  it 'should contain properties and methods', ->
    expect(Widget).to.include.keys [
      '_widgets'
      '_originRegex'
      'replaceTagWithWidget'
      'hasOrigin'
      'getWidgetByWidgetId'
    ]
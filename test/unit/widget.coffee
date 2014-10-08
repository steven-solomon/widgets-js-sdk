describe 'CT.Widget', ->
  {Widget} = window.CrowdTwist

  it 'should exist', ->
    expect(Widget).to.exist

  it 'should contain properties and methods', ->
    expect(Widget).to.include.keys [
      '_widgets'
      '_originRegex'
      'addWidget'
      'removeWidget'
      'replaceTagWithWidget'
      'hasOrigin'
      'getWidgetByWidgetId'
    ]
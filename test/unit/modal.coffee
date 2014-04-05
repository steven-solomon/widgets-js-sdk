describe 'CT.Modal', ->
  {Modal} = window.CT

  it 'should exist', ->
    expect(Modal).to.exist

  it 'should contain properties and methods', ->
    expect(Modal).to.include.keys [
      'initModalContainer'
      'showWithWidgetUrl'
      'hide'
    ]
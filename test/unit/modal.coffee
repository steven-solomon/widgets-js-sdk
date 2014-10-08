describe 'CT.Modal', ->
  {Modal} = window.CrowdTwist

  it 'should exist', ->
    expect(Modal).to.exist

  it 'should contain properties and methods', ->
    expect(Modal).to.include.keys [
      'initModalContainer'
      'setWidth'
      'show'
      'hide'
    ]
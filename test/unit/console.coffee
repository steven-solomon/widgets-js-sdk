describe 'CT.console', ->
  {console} = window.CrowdTwist

  it 'should exist', ->
    expect(console).to.exist

  it 'should contain properties and methods', ->
    expect(console).to.include.keys [
      'log'
      'group'
      'groupEnd'
      'time'
      'timeEnd'
    ]
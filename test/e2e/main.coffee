describe 'Widget SDK', ->
  beforeEach ->
    browser.get '/'

  it 'test page should load', ->
    expect(browser.driver.getTitle()).toEqual 'Widget SDK Test Page'

  it 'should initialize modal container', ->
    expect(exists('#ct-modal')).toBe true

    modalEl = $('#ct-modal')

    expect(modalEl.isDisplayed()).toBe false
    expect(modalEl.isElementPresent(By.css('button'))).toBe true
    expect(modalEl.isElementPresent(By.css('iframe'))).toBe true

  it 'should initialize modal background container', ->
    expect(exists('#ct-modal-background')).toBe true

    modalBackgroundEl = $('#ct-modal-background')

    expect(modalBackgroundEl.isDisplayed()).toBe false

// This file contains various helper methods that are globally available across all specs


/**
 * Replacement for default Protractor $ that bypasses Angular requirement
 *
 * @param sel [String] css selector string
 * @returns [webdriver.WebElement]
 */
browser.$ = function(sel) {
  return browser.driver.findElement(by.css(sel));
}

/**
 * Replacement for default Protractor browser.get that bypasses Angular requirement
 *
 * @param path [String] path relative to baseUrl
 * @returns [webdriver.promise.Promise] A promise that will be resolved when the document has finished loading.
 */
browser.get = function(path) {
  return browser.driver.get(browser.baseUrl + path);
}

/**
 * Helper method to determine if element exists by selector.
 *
 * @param sel [String] css selector string
 * @returns [Boolean]
 */
browser.exists = function(sel) {
  return browser.driver.isElementPresent(by.css(sel));
}


// Now we need to propagate these overrides globally
global.$ = browser.$;
global.exists = browser.exists;

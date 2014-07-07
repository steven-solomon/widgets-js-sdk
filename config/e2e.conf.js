exports.config = {
  // The address of a running selenium server.
  seleniumAddress: 'http://localhost:4444/wd/hub',

  // Capabilities to be passed to the webdriver instance.
  capabilities: {
    'browserName': 'phantomjs'
  },

  // URL of the app you want to test.
  baseUrl: 'http://localhost:3001',

  specs: [
    '../test/e2e/helper.js',
    '../build/e2e/**/*.js'
  ],

  framework: 'mocha',

  // Options to be passed to Mocha.
  mochaOpts: {
    reporter: 'spec'
  }
};

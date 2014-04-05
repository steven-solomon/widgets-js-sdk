# Widgets SDK for JavaScript

[![Build Status](https://travis-ci.org/CrowdTwist/widgets-js-sdk.svg?branch=develop)](https://travis-ci.org/CrowdTwist/widgets-js-sdk)

The [CrowdTwist](http://crowdtwist.com) Widgets SDK for JavaScript provides client-side functionality for embedding various Fan Center components such as Activities and Rewards directly into a third-party webpage.

## Dependencies

- [ES5-Shim](https://github.com/es-shims/es5-shim) - For IE 8 support

## Building

To build the final **sdk/widgets.js** file:

    $ npm install
    $ bower install
    $ npm run-script build

## Testing

### E2E *(test/e2e)*

- [Protractor](https://github.com/angular/protractor)
- [WebDriverJS](https://code.google.com/p/selenium/wiki/WebDriverJs)
- [Chai As Promised](http://chaijs.com/plugins/chai-as-promised)

### Unit *(test/unit)*

- [Mocha](http://visionmedia.github.io/mocha/)
- [Sinon.JS](http://sinonjs.org/)

To run the full test suite:

    $ npm install
    $ bower install
    $ npm test

# CrowdTwist Widgets SDK for JavaScript

[![Build Status](https://travis-ci.org/CrowdTwist/widgets-js-sdk.svg?branch=develop)](https://travis-ci.org/CrowdTwist/widgets-js-sdk)

The CrowdTwist Widgets SDK for JavaScript provides client-side functionality for embedding various Fan Center components such as Activities and Rewards directly into a third-party webpage.

## Dependencies

- [ES5-Shim](https://github.com/es-shims/es5-shim) - For IE 8 support

## Core Functionality

- Converting widget tags to iframes
- Handling communications between widgets and host page
- Displaying modal on host page

## Building

To build the final **sdk/widgets.js** file:

    $ npm install
    $ bower install
    $ npm run-script build

## Testing

[Protractor](https://github.com/angular/protractor) and [WebDriverJS](https://code.google.com/p/selenium/wiki/WebDriverJs) for automated selenium tests.

Specs are written in CoffeeScript and can be found in **test/specs/**.

To run the test suite:

    $ npm install
    $ bower install
    $ npm test

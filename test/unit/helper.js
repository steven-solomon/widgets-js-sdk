var chai = require('chai');
var sinon = require('sinon');
var sinonChai = require('sinon-chai');
chai.use(sinonChai);

global.sinon = sinon;
global.expect = chai.expect;
global.window = {
  CrowdTwist: {
    // fake out jQuery dependency
    '$': function () {
      return {
        on: function(eventName, handler) {
        }
      }
    }
  }
};

require('../../src/console');
require('../../src/event');
require('../../src/widget');
require('../../src/modal');
require('../../src/dispatch');
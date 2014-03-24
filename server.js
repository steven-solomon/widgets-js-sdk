var app, express;

express = require('express');
app = express();

app.use(express.static(__dirname + '/sdk'));

// Used to run e2e tests
app.get('/*', function(req, res) {
  res.sendfile('./test/index.html');
});

console.log("Running dev server on port 3001");
app.listen(3001);

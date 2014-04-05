var app, express;

express = require('express');
app = express();

// Properly serve urls with trailing slashes
app.use(function(req, res, next) {
  if (req.url.substr(-1) === '/' && req.url.length > 1)
    res.redirect(301, req.url.slice(0, -1));
  else
    next();
});

app.use(express.static(__dirname + '/sdk'));
app.use(express.static(__dirname + '/test'));

console.log("Running dev server on port 3001");
app.listen(3001);

var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
/** GET router ping */
router.get('/ping', function(req, res, next) {
  res.json({ message: 'Pong!'})
});

module.exports = router;

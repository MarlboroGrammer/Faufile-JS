var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.send({ title: 'Express' });
});

router.get('/services', function(req, res, next) {
  res.send({ title: 'Restauration' });
});

router.get('/regions', function(req, res, next) {
  res.send({ title: 'fa7s' });
});

module.exports = router;

var express = require('express');
var bcrypt = require('bcrypt-nodejs')

var router = express.Router()

var db = require('../helper/db.js')
var jwtHelper = require('../helper/jwt.js')

router.post('/' ,function(req, res) {
	const ticket =  {
		name: req.body.name
	}
	var keys = Object.keys(ticket)
	var values = keys.map((key) => { return "'" + service[key] + "'" })
	db.get().query('INSERT INTO tickets (' + keys.join(',') + ') VALUES (' + values.join(',') + ')', (err, rows) => {
    	if (err) 
    	 res.status(500).send(err)
    });
    res.send('success')
})
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});



module.exports = router;
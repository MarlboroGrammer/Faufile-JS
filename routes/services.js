 var express = require('express');
var bcrypt = require('bcrypt-nodejs')

var router = express.Router()

var db = require('../helper/db.js')
var jwtHelper = require('../helper/jwt.js')

router.post('/' ,function(req, res) {
	const service =  {
		name: req.body.name
	}
	var keys = Object.keys(service)
	var values = keys.map((key) => { return "'" + service[key] + "'" })
	db.get().query('INSERT INTO services (' + keys.join(',') + ') VALUES (' + values.join(',') + ')', (err, rows) => {
    	if (err) 
    	 res.status(500).send(err)
    });
    res.send('success')
})
router.get('/', function(req, res, next) {
  db.get().query('SELECT * FROM service' , function (err, rows) {
    if (err) 
    	return res.status(500).send({'error': err})
    return res.json(rows)
  })
});




module.exports = router;
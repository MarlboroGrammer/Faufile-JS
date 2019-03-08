var express = require('express');
var bcrypt = require('bcrypt-nodejs')

var router = express.Router()

var db = require('../helper/db.js')
var jwtHelper = require('../helper/jwt.js')

router.post('/' ,function(req, res) {
	const region =  {
		name: req.body.name
	}
	var keys = Object.keys(region)
	var values = keys.map((key) => { return "'" + region[key] + "'" })
	db.get().query('INSERT INTO regions (' + keys.join(',') + ') VALUES (' + values.join(',') + ')', (err, rows) => {
    	if (err) 
    	 res.status(500).send(err)
    });
    res.send('success')
})
router.get('/', function(req, res, next) {
	db.get().query('SELECT * FROM region' , function (err, rows) {
    	if (err) 
    		return res.status(500).send({'error': err})
    	return res.json(rows)
  	})
});



module.exports = router;
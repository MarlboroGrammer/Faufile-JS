var express = require('express');
var bcrypt = require('bcrypt-nodejs')

var router = express.Router()

var db = require('../helper/db.js')
var jwtHelper = require('../helper/jwt.js')

router.post('/' ,function(req, res) {
	const ticket =  {
		user_id: req.body.user || 1,
		service_id: req.body.service || 1,
		booking_time: req.body.booking_time || 110500
	}
	var keys = Object.keys(ticket)
	console.log(ticket)
	var values = keys.map((key) => { return "'" + ticket[key] + "'" })
	db.get().query('INSERT INTO ticket (' + keys.join(',') + ') VALUES (' + values.join(',') + ')', (err, rows) => {
    	if (err) return res.status(500).send(err)
    });
  return res.send('success')
})

router.get('/', function(req, res, next) {
	db.get().query('SELECT * FROM ticket' , function (err, rows) {
  	if (err) 
  		return res.status(500).send({'error': err})
  	return res.json(rows)
	})
});

router.get('/last/:id', function (req, res, next) {
	db.get().query('SELECT MAX(id) as ticket FROM ticket WHERE service_id = ?', [req.params.id], function (err, rows) {
  	if (err) 
  		return res.status(500).send({'error': err})
  	return res.json(rows)
	})
})

module.exports = router;
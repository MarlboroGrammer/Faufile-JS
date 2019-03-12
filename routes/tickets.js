var express = require('express');
var bcrypt = require('bcrypt-nodejs')

var router = express.Router()

var db = require('../helper/db.js')
var jwtHelper = require('../helper/jwt.js')

router.post('/' ,function(req, res) {
	console.log(req.body);
	const ticket =  {
		user_id: req.body.user_id || 1,
		service_id: req.body.service_id || 1,
		booking_time: req.body.booking_time || 110500
	}
	db.get().query('SELECT * FROM `ticket`  WHERE `service_id` = ? AND' + 
	' ? BETWEEN `booking_time` AND `booking_time` + 000500', [ticket.service_id, ticket.booking_time], function (err, rows) {
		if (err) {
			console.log('An error has occured', err);
			return res.status(500).send(err)
		}
		if (rows.length > 0) {
			return res.status(400).send({'error': 'Tickto no attemasu'})
		}
		var keys = Object.keys(ticket);
		console.log(ticket)
		var values = keys.map((key) => { return "'" + ticket[key] + "'" })
		db.get().query('INSERT INTO ticket (' + keys.join(',') + ') VALUES (' + values.join(',') + ')', function (err, rows) {
	    	if (err) return res.status(500).send(err)
	    });
	  return res.json({message: 'success'})
	})
})

router.get('/', function(req, res, next) {
	db.get().query('SELECT * FROM ticket' , function (err, rows) {
  	if (err) 
  		return res.status(500).send({'error': err})
  	return res.json(rows)
	})
});

router.get('/user/:id', function(req, res, next) {
	db.get().query('SELECT ticket.id, ticket.booking_time, service.name FROM ticket JOIN service ON ticket.service_id = service.id WHERE ticket.user_id = ?', [req.params.id], function (err, rows) {
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
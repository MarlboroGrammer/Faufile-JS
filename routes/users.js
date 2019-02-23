var express = require('express');
var bcrypt = require('bcrypt-nodejs')

var router = express.Router()

var db = require('../helper/db.js')
var jwtHelper = require('../helper/jwt.js')


router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.post('/' ,function(req, res, next) {
	const user =  {
		name: req.body.name, 
		email: req.body.email, 
		password: bcrypt.hashSync(req.body.password, bcrypt.genSaltSync(32))
	}
	var keys = Object.keys(user)
	var values = keys.map((key) => { return "'" + user[key] + "'" })
	db.get().query('INSERT INTO users (' + keys.join(',') + ') VALUES (' + values.join(',') + ')', (err, rows) => {
    	if (err){
    		res.status(500).send(err);
    	}
    	console.log(rows);
    });
    res.json('success')
});
router.post('/auth', function (req, res) {
  db.get().query('SELECT * FROM users WHERE email = ?', [req.body.email], function (err, rows) {
    if (err) 
    	return res.status(500).send(err)
    if(rows.length === 0) {
    	return res.status(404).send('nope')
    }
    if (bcrypt.compareSync(req.body.password, rows[0].password)) {
    	return res.json({user: rows[0], token: jwtHelper.jwtSignUser(req.body.email)})
    }	
    res.status(401).send('nope')
  }) 
})


module.exports = router;
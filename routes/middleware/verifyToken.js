var jwt = require('jsonwebtoken')

module.exports.authenticate = function (req, res, next) {
  var header = req.headers.authorization
  if (header) {
    var token = header.split(' ')[1]
    jwt.verify(token, 'secret', function (err, result) {
      if (err) {
        res.send(err)
      } else {
        next()
      }
    })
  } else {
    res.status(403).json('UNAUTHORIZED')
  }
}

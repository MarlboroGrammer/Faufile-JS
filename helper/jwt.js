var jwt = require('jsonwebtoken')

exports.jwtSignUser = (username) => {
  // const ONE_WEEK = 60 * 60 * 24 * 7
  return jwt.sign(username, 'secret', null)
}
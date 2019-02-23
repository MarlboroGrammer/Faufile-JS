var mysql = require('mysql')
  , async = require('async')

var PRODUCTION_DB = 'vidovii_database'
  , TEST_DB = 'taktak'

exports.MODE_TEST = 'mode_test'
exports.MODE_PRODUCTION = 'mode_production'

var state = {
  pool: null,
  mode: null,
}

exports.connect = function(mode, done) {
  state.pool = mysql.createPool({
    host: mode === exports.MODE_PRODUCTION ? '41.231.123.60' : 'localhost',
    user: mode === exports.MODE_PRODUCTION ? 'vidovii' : 'root',
    password: mode === exports.MODE_PRODUCTION ? 'wKe)xnDRHwb9' : '',
    database: mode === exports.MODE_PRODUCTION ? PRODUCTION_DB : TEST_DB
  })

  state.mode = mode
  done()
}

exports.get = function() {
  return state.pool
}

exports.fixtures = function(data) {
  var pool = state.pool
  if (!pool) return done(new Error('Missing database connection.'))

  var names = Object.keys(data.tables)
  async.each(names, function(name, cb) {
    async.each(data.tables[name], function(row, cb) {
      var keys = Object.keys(row)
        , values = keys.map(function(key) { return "'" + row[key] + "'" })

      pool.query('INSERT INTO ' + name + ' (' + keys.join(',') + ') VALUES (' + values.join(',') + ')', cb)
    }, cb)
  }, done)
}

exports.persistArray = function (tableName, array) {
  var pool = state.pool
  if (!pool) return done(new Error('Missing database connection.'))

  async.each(array, function (element ,cb) {
    var keys = Object.keys(v)
    var values = keys.map(function (key) { return "'" + v[key] + "'" })
    pool.query('INSERT INTO ' + tableName + ' (' + keys.join(',') + ') VALUES (' + values.join(',') + ')', cb)
  }, done)
}

exports.drop = function(tables, done) {
  var pool = state.pool
  if (!pool) return done(new Error('Missing database connection.'))

  async.each(tables, function(name, cb) {
    pool.query('DELETE * FROM ' + name, cb)
  }, done)
}


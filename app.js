var express = require('express');
var path = require('path')
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var cors = require('cors')

var db = require('./helper/db.js')

var index = require('./routes/index');
var users = require('./routes/users');
var services = require('./routes/services');
var tickets = require('./routes/tickets');
var regions = require('./routes/regions');
var app = express();

// view engine setup
app.set('view engine', 'html');

const BASE_URL = '/api'
// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(cors())
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true, limit:'10gb' }));
// app.use(history())
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'dist')));

app.use(BASE_URL + '/', index);
app.use(BASE_URL + '/users', users);
app.use(BASE_URL + '/services', services);
app.use(BASE_URL + '/regions', regions);
app.use(BASE_URL + '/tickets', tickets);

app.get('*', function(req, res) {
  res.sendFile(path.join(__dirname, 'index.html'), (err) => {
    if (err) res.status(500).send(err)
  })
})

//Manually enable cors
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
  res.header("Access-Control-Allow-Methods", "POST,GET,PUT,DELETE,OPTIONS,HEAD")
  next();
});
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
    
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;


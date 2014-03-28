express = require 'express'
stylus = require('stylus')
coffeescript = require('connect-coffee-script')
path = require('path')
config = require('../config')
axis = require('axis-css')
grate = require('grate')
require('./precompile')()

module.exports = server = express()

server = express()
server.set('views', "#{__dirname}/views")
server.set('view engine', 'jade')
server.use(express.logger('dev'))

server.use stylus.middleware(
  src: __dirname + '/assets'
  dest: __dirname + '/public'
  compile: (str, path) -> stylus(str).set('filename', path).use(axis()).use(grate())
)

server.use coffeescript(
  src: __dirname + '/assets'
  dest: __dirname + '/public'
)

# allow express to parse body params
server.use(express.bodyParser())

# serve assets for roots-cms
server.use(express.static(path.join(__dirname, 'public')))

# serve assets for the roots project
server.use(express.static(path.join(config.project_dir, 'assets')))

# set up basic auth if enabled
if config.basic_auth
  server.use(express.basicAuth(config.basic_auth.username, config.basic_auth.password))

# load the api
server.use(require('./api'))

# respond to all other requests with the marionette SPA
server.get "*", (req, res) ->
  res.render 'index'

server.listen(process.env.PORT || 2222)

express = require 'express'
path    = require('path')
config  = require('../config')
api     = require('./api')

module.exports = server = express()


#### auth & setup #####

if config.basic_auth
  server.use(express.basicAuth(config.basic_auth.username, config.basic_auth.password))

server.use(express.logger('dev'))

server.use(express.bodyParser())


#####    api      #####

server.use(api)


#####   static    #####

# roots-cms client assets
server.use(express.static(path.join(__dirname, '..', 'client', 'public')))

# roots project assets
server.use(express.static(path.join(config.project_dir, 'assets')))

# roots-cms marionette SPA
server.get "*", (req, res) ->
  res.sendfile(path.join(__dirname, '..', 'client', 'public', 'index.html'))

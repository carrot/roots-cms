express = require 'express'
path    = require('path')
api     = require('../api')
W       = require 'when'
Roots   = require 'roots'

client_path = path.join(__dirname, '..', '..', '..', 'roots-cms-client')
new_client  = require(path.join(client_path, 'lib'))

class Server

  constructor: (@cms) ->
    if not @cms then throw Error 'no cms object given to configure'
    @config = @cms.config
    @_server = express()
    configure_server.call(@)

  start: ->
    compile_client().with(@).then ->
      @_http_server = @_server.listen(@config.port)

  stop: ->
    @_http_server.close()
    W.resolve()

  ### private ###

  compile_client = ->
    new_client(env: 'production').compile()

  configure_server = ->
    if @config.env == 'development'
      @_server.use(express.logger('dev'))

    @_server.use(express.bodyParser())

    if @config.basic_auth
      @_server.use(express.basicAuth(@config.basic_auth.username, @config.basic_auth.password))

    # roots-cms client assets
    @_server.use(express.static(path.join(client_path, 'public')))

    # roots project assets
    @_server.use(express.static(path.join(@cms.root, 'assets')))

    api(@cms, @_server)

    # roots-cms marionette SPA
    @_server.get "*", (req, res) ->
      res.sendfile(path.join(client_path, 'public', 'index.html'))

module.exports = Server

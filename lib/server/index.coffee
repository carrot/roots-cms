express = require 'express'
path    = require('path')
api     = require('../api')
W       = require 'when'
Roots   = require 'roots'

client  = require('roots-cms-client')({env: 'production'})

class Server

  constructor: (@cms) ->
    if not @cms then throw Error 'no cms object given to configure'
    @config = @cms.config
    @_server = express()
    configure_server.call(@)

  start: ->
    compile_client.call(@).with(@).then ->
      @_http_server = @_server.listen(@config.port)

  stop: ->
    @_http_server.close()
    W.resolve()

  ### private ###

  compile_client = ->
    if @config.env == 'test' then W.resolve() else client.compile()

  configure_server = ->
    if @config.env == 'development'
      @_server.use(express.logger('dev'))

    @_server.use(express.bodyParser())

    if @config.basic_auth
      @_server.use(express.basicAuth(@config.basic_auth.username, @config.basic_auth.password))

    client_path = path.join(__dirname, '..', '..', 'node_modules', 'roots-cms-client', 'public')

    # roots-cms client assets
    @_server.use(express.static(client_path))

    # roots project assets
    @_server.use(express.static(path.join(@cms.root, 'assets')))

    # load api
    api(@cms, @_server)

    # roots-cms marionette SPA
    @_server.get "*", (req, res) ->
      res.sendfile(path.join(client_path, 'index.html'))

module.exports = Server

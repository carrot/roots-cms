express = require 'express'
path    = require('path')
api     = require('../api')
W       = require 'when'

Roots   = require 'roots'

class Server

  constructor: (@cms) ->
    if not @cms then throw Error 'no cms object given to configure'
    @config = @cms.config
    @_server = express()
    configure_server.call(@)

  start: ->
    compile_client().with(@).then ->
      @_http_server = @_server.listen(process.env.PORT || 2222)

  stop: ->
    @_http_server.close()
    W.resolve()

  ### private ###

  compile_client = ->
    client = new Roots(path.join(__dirname, '..', 'client'))
    client.compile()

  configure_server = ->
    if @config.env == 'development'
      @_server.use(express.logger('dev'))

    @_server.use(express.bodyParser())

    if @config.basic_auth
      @_server.use(express.basicAuth(@config.basic_auth.username, @config.basic_auth.password))

    # roots-cms client assets
    @_server.use(express.static(path.join(__dirname, '..', 'client', 'public')))

    # roots project assets
    @_server.use(express.static(path.join(@cms.root, 'assets')))

    api(@cms, @_server)

    # roots-cms marionette SPA
    @_server.get "*", (req, res) ->
      res.sendfile(path.join(__dirname, '..', 'client', 'public', 'index.html'))

module.exports = Server

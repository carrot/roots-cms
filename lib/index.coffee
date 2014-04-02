path    = require 'path'
fs      = require 'fs'
W       = require 'when'
Roots   = require 'roots'

client    = new Roots(path.join(__dirname, 'client'))
Server    = require './server'
Config    = require './config'
Category  = require './category'
Content   = require './content'

class RootsCMS
  constructor: (@root, opts = {}) ->
    if not @root then throw new Error('no project path given')
    if not fs.existsSync(@root) then throw new Error("no project found at #{@root}")
    configure_cms.call(@, opts)

  start: ->
    def = W.defer()
    compile_client().with(@)
      .then(start_server)
      .then -> def.resolve()
      .catch (e) -> throw e
    return def.promise

  stop: ->
    @server.stop()
    W.resolve()

  all: ->
    Category.all(@, path.join(@config.project_dir, @config.content_dir))

  find_content: (id) ->
    new Content(@, id)

  update_content: (id, data, markdown) ->
    content = new Content(@, id)
    content.set('data', data)
    content.set('content', markdown)
    content.save()

  ### private ###

  configure_cms = (opts) ->
    @config = new Config(@, opts)

  compile_client = ->
    def = W.defer()
    client.compile()
      .on 'error',  -> def.reject()
      .on 'done',   -> def.resolve()
    return def.promise

  start_server = ->
    @server = new Server(@)
    @server.start()
    W.resolve()

module.exports = RootsCMS

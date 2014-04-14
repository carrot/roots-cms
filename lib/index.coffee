path    = require 'path'
fs      = require 'fs'
W       = require 'when'

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
    start_server.call(@).catch((e) -> throw e)

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

  start_server = ->
    console.log(@)
    @server = new Server(@)
    @server.start()

module.exports = RootsCMS

path    = require 'path'
fs      = require 'fs'
W       = require 'when'
Roots   = require 'roots'

client  = new Roots(path.join(__dirname, 'client'))
server  = require './server'

class RootsCMS
  constructor: (@project) ->
    if not @project then throw new Error('no project path given')
    if not fs.existsSync(@project) then throw new Error("no project found at #{@project}")

  start: ->
    def = W.defer()
    compile_client()
      .then(start_server)
      .then(-> def.resolve())
    return def.promise

  ### private ###

  compile_client = ->
    def = W.defer()
    client.compile()
      .on 'error',  -> def.reject()
      .on 'done',   -> def.resolve()
    return def.promise

  start_server = ->
    server.listen(process.env.PORT || 7777)

module.exports = RootsCMS

path = require('path')
assert = require('assert')
should = require('should')
api = require(path.join(__dirname, '..', 'api'))
port = 3333

describe 'api', ->
  before (done) ->
    @server = api.listen port, (err, res) ->
      if err then done(err) else done()

  after (done) ->
    @server.close -> done()

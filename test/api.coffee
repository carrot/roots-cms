path = require('path')
assert = require('assert')
should = require('should')
http = require('http')
ContentLoader = require('../lib/content_loader')

api = require(path.join(__dirname, '..', 'api'))
port = 3333

headers = (path) ->
  opts =
    'host': 'localhost'
    'port': port
    'path': path
    'method': 'GET'
    'headers':
      'Cookie': null


describe '/api', ->
  before (done) ->
    @server = api.listen port, (err, res) ->
      if err then done(err) else done()

  after (done) ->
    @server.close -> done()

  describe '/api/content', ->
    it 'should serve all the content', (done) ->
      ContentLoader.detect process.cwd(), (err, files) ->
        http.get headers('/api/content'), (res) ->
          res.statusCode.should.eql(200)

          body = ''
          res.on 'data', (chunk) -> body += chunk
          res.on 'end', ->
            JSON.parse(body).length.should.eql(files.length)
            done()

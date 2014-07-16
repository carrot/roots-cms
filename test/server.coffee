path      = require 'path'
expect    = require('chai').expect
Browser   = require 'zombie'
browser   = new Browser
RootsCMS  = require '../lib'
Server    = require '../lib/server'


describe 'Server', ->
  before ->
    @port    = 2222
    @url     = "http://localhost:#{@port}/api/categories.json"
    @project = path.join(__dirname, 'fixtures', 'project_without_config')

  describe '#constructor()', ->

    it 'raises an error if no CMS object is passed in', ->
      expect(-> new Server).to.throw /no cms object given/

  describe 'start/stop the server', ->

    before (done) ->
      @cms    = new RootsCMS(@project, {env: 'test'})
      @server = new Server(@cms)
      @server.start().then(-> done()).catch((e) -> done(e))

    describe '#start()', ->

      it 'starts a server on default port 2222', (done) ->
        browser.visit(@url).then ->
          expect(browser.success).to.be.true
          done()

    describe '#stop()', ->

      it 'stops the server', (done) ->
        @server.stop()
          .then -> browser.visit(@url)
          .then ->
            expect(browser.success).to.be.false
            done()
          .catch (e) -> done(e)

path      = require 'path'
expect    = require('chai').expect
Browser   = require 'zombie'
browser   = new Browser
RootsCMS  = require '../lib'


describe 'RootsCMS', ->
  before ->
    @port = 2222
    @url  = "http://localhost:#{@port}/"

  describe '#constructor()', ->

    it 'raises an error if no project path is given', ->
      expect(-> new RootsCMS).to.throw /no project path given/

    it 'raises an error if a non existent project path is given', ->
      project = path.join('not', 'a', 'real', 'path', 'asdfqwerzxcvpoiuqwerasdf')
      expect(-> new RootsCMS(project)).to.throw /no project found at/

  describe 'start/stop the server', ->

    before (done) ->
      project = path.join(__dirname, 'fixtures', 'test_project')
      @cms     = new RootsCMS(project)
      @cms.start().then(-> done()).catch((e) -> done(e))

    describe '#start()', (done) ->

      it 'starts a server on default port 2222', (done) ->
        browser.visit(@url).then ->
          expect(browser.success).to.be.true
          done()

    describe '#stop()', ->

      it 'stops the server', (done) ->
        @cms.stop()
          .then(-> browser.visit(@url))
          .then(->
            expect(browser.success).to.be.false
            done()
          ).catch (e) -> done(e)

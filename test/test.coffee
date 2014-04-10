path      = require 'path'
expect    = require('chai').expect
Browser   = require 'zombie'
browser   = new Browser
RootsCMS  = require '../lib'
Config    = require '../lib/config'


describe 'RootsCMS', ->
  before ->
    @port = 2222
    @url  = "http://localhost:#{@port}/"
    @project = path.join(__dirname, 'fixtures', 'project_without_config')

  describe '#constructor()', ->

    it 'raises an error if no project path is given', ->
      expect(-> new RootsCMS).to.throw /no project path given/

    it 'raises an error if a non existent project path is given', ->
      project = path.join('not', 'a', 'real', 'path', 'asdfqwerzxcvpoiuqwerasdf')
      expect(-> new RootsCMS(project)).to.throw /no project found at/

    it 'sets up the configuration', ->
      cms = new RootsCMS(@project)
      expect(cms.config).to.be.an.instanceof(Config)

  describe 'start/stop the server', ->

    before (done) ->
      @cms = new RootsCMS(@project, {env: 'test'})
      @cms.start().then(-> done()).catch((e) -> done(e))

    describe '#start()', (done) ->

      it 'starts a server on default port 2222', (done) ->
        browser.visit(@url).then ->
          expect(browser.success).to.be.true
          done()

    describe '#stop()', ->

      it 'stops the server', (done) ->
        @cms.stop()
          .then -> browser.visit(@url)
          .then ->
            expect(browser.success).to.be.false
            done()
          .catch (e) -> done(e)

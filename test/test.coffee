path      = require 'path'
expect    = require('chai').expect
Browser   = require 'zombie'
RootsCMS  = require '../lib'


describe 'RootsCMS', ->

  describe '#constructor()', ->

    it 'raises an error if no project path is given', ->
      expect(-> new RootsCMS).to.throw /no project path given/

    it 'raises an error if a non existent project path is given', ->
      project = path.join('not', 'a', 'real', 'path', 'asdfqwerzxcvpoiuqwerasdf')
      expect(->new RootsCMS(project)).to.throw /no project found at/

  describe '#start()', ->

    it 'starts a server on default port 2222', ->
      project = path.join(__dirname, 'fixtures', 'test_project')
      cms     = new RootsCMS(project)

      cms.start()
        .then(Browser.visit, 'http://localhost:2222/')
        .then((e, browser) -> assert.ok(browser.success))

expect    = require('chai').expect
Config    = require '../lib/config'


describe 'Config', ->

  describe '#constructor()', ->

    it 'raises an error if no CMS object is passed in', ->
      expect(-> new Config).to.throw /no cms object given/

    it 'raises an error if no CMS object is passed in'

    it "should load config from the project's cms.json"

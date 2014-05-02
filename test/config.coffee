path      = require 'path'
expect    = require('chai').expect
RootsCMS  = require '../lib'
Config    = require '../lib/config'


describe 'Config', ->

  describe '#constructor()', ->

    it 'raises an error if no CMS object is passed in', ->
      expect(-> new Config).to.throw /no cms object given/

  describe 'without cms.json in the project', ->
    before ->
      @project= path.join(__dirname, 'fixtures', 'project_without_config')
      @cms    = new RootsCMS(@project)
      @config = new Config(@cms)

    it 'has all the default keys', ->
      expect(@cms.config).to.include.keys(Object.keys(Config.defaults))

    it 'has the default value for basic_auth', ->
      expect(@cms.config.auth).to.eq false

  describe 'with cms.json in the project', ->
    before ->
      @project  = path.join(__dirname, 'fixtures', 'project_with_config')
      @cms      = new RootsCMS(@project)
      @config   = new Config(@cms)

    it 'has the cms.json value for basic_auth', ->
      expect(@cms.config.auth).to.eq 'username:password'

    describe 'and overrides passes into the constructor', ->
      before ->
        @cms    = new RootsCMS(@project)
        @config = new Config(@cms, {'basic_auth': 'username:override'})

      it 'options passes into the Config constructor override all values', ->
        expect(@config.basic_auth).to.eq 'username:override'

path        = require 'path'
fs          = require 'fs'
expect      = require('chai').expect
shell       = require 'shelljs'

RootsCMS  = require '../lib'
Uploader  = require '../lib/uploader'

describe 'Uploader', ->

  describe '#constructor()', ->

    it 'raises an error if no CMS object is passed in', ->
      expect(-> new Uploader).to.throw /no cms object given/

  describe 'BaseUploader', ->

    before ->
      @project    = path.join(__dirname, 'fixtures', 'project_without_config')
      @cms        = new RootsCMS(@project)
      @uploader   = new Uploader(@cms)
      @file_path  = path.join(__dirname, 'fixtures', 'img', 'doge.jpg')
      @upload_dir = @cms.config.uploader.dir.replace('assets', '')

    it 'returns the url with the correct path', (done) ->
      @uploader.upload(@file_path).done (url) =>
        expect(url).to.contain(@upload_dir)
        done()

    it 'returns the url with the correct extension', (done) ->
      @uploader.upload(@file_path).done (url) =>
        expect(path.extname(url)).to.eq(path.extname(@file_path))
        done()

    it 'the written file exists in the image directory', (done) ->
      @uploader.upload(@file_path).done (url) =>
        fs.exists(path.join(@cms.config.project_dir, 'assets', url), (exists) ->
          expect(exists).to.be.true
          done()
        )

    after ->
      shell.exec("rm -rf #{path.join(@project, 'assets', 'img', 'uploads')}")

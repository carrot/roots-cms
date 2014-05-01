path    = require 'path'
fs      = require 'fs'
W       = require 'when'
nodefn  = require 'when/node/function'
mkdirp  = require 'mkdirp'

class BaseUploader
  constructor: (@cms) ->
    @config = @cms.config

  upload: (@file_path) ->
    @setup().with(@)
      .then(@read_file)
      .then(@upload_file)
      .then(@return_url)

  setup: ->
    @file_name = "img_#{(new Date).getTime()}#{path.extname(@file_path)}"
    W.resolve()

  read_file: ->
    nodefn.call(fs.readFile, @file_path)

  upload_file: (buf) ->
    upload_dir = path.join(@config.project_dir, @config.uploader.dir)
    nodefn.call(mkdirp, upload_dir).with(@)
      .then(-> nodefn.call(fs.writeFile, path.join(upload_dir, @file_name), buf))

  return_url: ->
    W.resolve(path.join(@config.uploader.dir.replace('assets', ''), @file_name))

module.exports = BaseUploader

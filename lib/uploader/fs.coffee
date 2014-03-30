path    = require 'path'
fs      = require 'fs'
config  = require '../config'
W       = require 'when'
nodefn  = require 'when/node/function'
mkdirp  = require 'mkdirp'

class FSUploader
  constructor: ->
    @upload_dir = path.join(config.project_dir, 'assets', 'img', config.img_upload_dir)

  upload: (@file_path) ->

    @_create_upload_dir()
      .then(@_read_file.bind(@))
      .then(@_write_file.bind(@))
      .then(@_return_url.bind(@))

  _read_file: ->
    nodefn.call(fs.readFile, @file_path)

  _create_upload_dir: ->
    nodefn.call(mkdirp, @upload_dir)

  _write_file: (buf) ->
    @file_name = "img_#{(new Date).getTime()}#{path.extname(@file_path)}"
    nodefn.call(fs.writeFile, path.join(@upload_dir, @file_name), buf)

  _return_url: ->
    W.resolve(path.join("/img", config.img_upload_dir, @file_name))

module.exports = FSUploader

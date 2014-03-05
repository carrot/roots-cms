path = require('path')
fs = require('fs')
config = require('../config')
W = require('when')
nodefn = require('when/node/function')
aws_client = require('../aws_client')
mkdirp = require('mkdirp')

class FSUploader
  constructor: ->
    @upload_dir = path.join(config.project_dir, 'assets', 'img', config.img_upload_dir)
    @file_name = "img_#{(new Date).getTime()}.png"

  upload: (@buf) ->
    @_create_upload_dir()
      .then(@_write_file.bind(@))
      .then(@_return_url.bind(@))

  _create_upload_dir: ->
    nodefn.call(mkdirp, @upload_dir)

  _write_file: ->
    nodefn.call(fs.writeFile, path.join(@upload_dir, @file_name), @buf)

  _return_url: ->
    W.resolve(path.join("/img", config.img_upload_dir, @file_name))

module.exports = FSUploader

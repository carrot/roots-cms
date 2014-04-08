fs          = require 'fs'
path        = require 'path'
config      = require '../config'
W           = require 'when'
nodefn      = require 'when/node/function'
aws_client  = require '../aws_client'

class S3Uploader

  constructor: ->
    @client = aws_client

  upload: (@file_path) ->
    @_read_file()
      .then(@_write_file.bind(@))

  _read_file: ->
    nodefn.call(fs.readFile, @file_path)

  _write_file: (buf) ->
    def = W.defer()

    @file_name = "img_#{(new Date).getTime()}#{path.extname(@file_path)}"

    req = @client.put "#{config.img_upload_dir}/#{@file_name}",
      'Content-Length': buf.length
      'Content-Type': 'image/jpg'
      'x-amz-acl': 'public-read'

    req.on 'response', (res) ->
      if 200 == res.statusCode
        console.log('S3Uploader saved image to %s', req.url)
        def.resolve(req.url)

    req.end(buf)

    return def.promise

module.exports = S3Uploader

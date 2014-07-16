knox  = require 'knox'
W     = require 'when'
mime  = require 'mime'

class AWS
  constructor: (@cms) ->
    @config = @cms.config
    @client = knox.createClient
      key: @config.uploader.key
      secret: @config.uploader.secret
      bucket: @config.uploader.bucket

  upload: (file_name, buf) ->
    def = W.defer()

    req = @client.put file_name,
      'Content-Length': buf.length
      'Content-Type': mime.lookup(file_name)
      'x-amz-acl': 'public-read'

    req.on 'response', (res) ->
      if res.statusCode == 200
        console.log('S3Uploader uploaded file to %s', req.url)
        def.resolve(req.url)

    req.end(buf)
    return def.promise

module.exports = AWS

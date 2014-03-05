W = require('when')
aws_client = require('../aws_client')

class S3Uploader

  constructor: ->
    @client = aws_client

  upload: (buf) ->
    deferred = W.defer()

    req = @client.put "/uploads/#{"img_#{(new Date).getTime()}.png"}",
      'Content-Length': buf.length
      'Content-Type': 'image/jpg'
      'x-amz-acl': 'public-read'

    req.on 'response', (res) ->
      if 200 == res.statusCode
        console.log('S3Uploader saved image to %s', req.url)
        deferred.resolve(req.url)

    req.end(buf)

    return deferred.promise

module.exports = S3Uploader

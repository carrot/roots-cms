config  = require '../config'
W       = require 'when'
aws     = require '../utils/aws'

class S3Uploader

  upload: (buf) ->
    deferred = W.defer()

    file_name = "img_#{(new Date).getTime()}.png"

    req = aws.put "#{config.img_upload_dir}/#{file_name}",
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

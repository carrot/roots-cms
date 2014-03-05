config = require('./config')
S3Uploader = require('./uploaders/s3_uploader')
FSUploader = require('./uploaders/fs_uploader')

class Uploader
  constructor: ->
    switch config.uploader
      when 's3'
        return new S3Uploader
      else
        return new FSUploader

module.exports = Uploader

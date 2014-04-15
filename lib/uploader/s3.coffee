W             = require 'when'
AWS           = require '../utils/aws'
BaseUploader  = require './base'

class S3Uploader extends BaseUploader
  upload_file: (buf) ->
    aws = new AWS(@cms)
    aws.upload("#{@config.img_upload_dir}/#{@file_name}", buf)

  return_url: (url) ->
    W.resolve(url)

module.exports = S3Uploader

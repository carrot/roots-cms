class Uploader
  @uploaders:
    s3: require('./s3')
    fs: require('./base')

  constructor: (@cms) ->
    @config = @cms.config

  upload: (file_path) ->
    uploader = new (Uploader.uploaders[@config.uploader])(@cms)
    uploader.upload(file_path).catch((e) -> throw e)

module.exports = Uploader

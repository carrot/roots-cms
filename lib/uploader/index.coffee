class Uploader
  @uploaders:
    s3: require('./s3')
    fs: require('./base')

  constructor: (@cms) ->
    if not @cms then throw Error 'no cms object given to configure'
    @config = @cms.config

  upload: (file_path) ->
    uploader = (new (Uploader.uploaders[@config.uploader.adapter])(@cms))
    uploader.upload(file_path).catch((e) -> throw e)

module.exports = Uploader

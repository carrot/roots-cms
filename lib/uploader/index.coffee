class Uploader
  @uploaders:
    s3: require('./s3')
    fs: require('./base')

  constructor: (@cms) ->
    @config = @cms.config

  upload: (file_path) ->
    uploader = new (Uploader.uploaders[@config.uploader])(@cms)
    uploader.setup(file_path).with(uploader)
      .then(uploader.read_file)
      .then(uploader.upload_file)
      .then(uploader.return_url)
      .catch((e) -> throw e)

module.exports = Uploader

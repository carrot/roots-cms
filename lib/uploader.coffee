config = require('./config')

uploaders =
  s3: require('./uploaders/s3_uploader')
  fs: require('./uploaders/fs_uploader')

module.exports =
  init: -> new uploaders[config.uploader]

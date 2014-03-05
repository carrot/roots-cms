config = require('./config')

uploaders =
  s3: require('./uploaders/s3_uploader')
  fs: require('./uploaders/fs_uploader')

class Uploader
  constructor: -> uploaders[config.uploader]

module.exports = Uploader

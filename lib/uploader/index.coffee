config = require('../config')

uploaders =
  s3: require('./s3')
  fs: require('./fs')

module.exports =
  init: -> new uploaders[config.uploader]

knox = require('knox')
config = require('../config')

if config.aws
  module.exports = knox.createClient
    key: config.aws.key
    secret: config.aws.secret
    bucket: config.aws.bucket

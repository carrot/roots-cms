path = require('path')
fs = require('fs')
config = require('../config')
W = require('when')
aws_client = require('../aws_client')
mkdirp = require('mkdirp')

class FSUploader

  upload: (buf) ->
    deferred = W.defer()

    uploads_dir = path.join(config.project_dir, 'assets', 'img', config.img_upload_dir)
    file_name = "img_#{(new Date).getTime()}.png"

    mkdirp uploads_dir, (err) ->
      if err then return console.error(err)

      fs.writeFile path.join(uploads_dir, file_name), buf, (err) ->
        if err then return console.error(err)
        deferred.resolve(path.join("/img", config.img_upload_dir, file_name))

    return deferred.promise

module.exports = FSUploader

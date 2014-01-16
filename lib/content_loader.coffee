fs = require('fs')
readdirp = require('readdirp')
W = require('when')
Content = require('./content')

module.exports =
  all: (dir) ->
    deferred = W.defer()

    @_detect_content_files(dir).then (files) =>
      deferred.resolve(new Content(f.path) for f in files)

    return deferred.promise

  _detect_content_files: (dir, cb) ->
    deferred = W.defer()
    files_array = []
    detection = []

    readdirp(root: dir, directoryFilter: ['!.git', '!node_modules', '!public'])
      .on 'end', =>
        W.all(detection).then => deferred.resolve(files_array)
      .on 'data', (f) =>
        detection.push(@_detect_file(f, files_array))

    return deferred.promise

  _detect_file: (file, files_array) ->
    deferred = W.defer()
    res = false

    fs.createReadStream(file.fullPath, {encoding: 'utf-8', start: 0, end: 3})
      .on('error', deferred.reject)
      .on('end', -> deferred.resolve(res))
      .on 'data', (data) =>
        if data.split('\n')[0] == '---'
          res = true
          files_array.push(file)
        deferred.resolve(res)

    return deferred.promise

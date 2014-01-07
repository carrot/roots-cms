fs = require('fs')
readdirp = require('readdirp')
W = require('when')
Content = require('./content')

module.exports =
  load: (file_paths) -> return (new Content(path) for path in file_paths)

  detect: (dir, cb) ->
    files = []

    readdirp(root: dir)
      .on 'end', =>
        cb(null, files)
      .on 'data', (f) =>
        @_detect_file(f.fullPath)
          .then((res) => if res then files.push(f.fullPath))

  _detect_file: (f) ->
    deferred = W.defer()
    res = false

    fs.createReadStream(f, {encoding: 'utf-8', start: 0, end: 3})
      .on('error', deferred.reject)
      .on('end', -> deferred.resolve(res))
      .on 'data', (data) ->
        if data.split('\n')[0] == '---' then res = true

    return deferred.promise

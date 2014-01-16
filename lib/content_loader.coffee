fs = require('fs')
readdirp = require('readdirp')
W = require('when')
Content = require('./content')

module.exports =
  all: (dir) ->
    deferred = W.defer()

    @_detect_content_files dir, (err, files) =>
      content = @_load_content_from_files(files)
      content = (c for c in content)
      deferred.resolve(content)

    return deferred.promise

  _load_content_from_files: (files) ->
    return (new Content(f.path) for f in files)

  _detect_content_files: (dir, cb) ->
    files = []

    readdirp(root: dir, directoryFilter: ['!.git', '!node_modules', '!public'])
      .on 'end', =>
        cb(null, files)
      .on 'data', (f) =>
        @_detect_file(f.fullPath)
          .then (res) => if res then files.push(f)

  _detect_file: (path) ->
    deferred = W.defer()
    res = false

    fs.createReadStream(path, {encoding: 'utf-8', start: 0, end: 3})
      .on('error', deferred.reject)
      .on('end', -> deferred.resolve(res))
      .on 'data', (data) ->
        if data.split('\n')[0] == '---' then res = true

    return deferred.promise

fs = require('fs')
readdirp = require('readdirp')
W = require('when')
_ = require('underscore')
ContentCollection = require('./content_collection')

class ContentLoader
# Grab all dynamic content files from process' current working directory,
# or you can pass in your own dir

  constructor: (root_dir) ->
    @root_dir = root_dir || process.cwd()
    @content_files = []

# group all content files by directory and create a ContentCollection
# for each

  load_collections: ->
    deferred = W.defer()

    @parse_root_dir().then => 
      cats = _.uniq(_.map(@content_files, (f) -> f.parentDir))
      collections = []
      _.each cats, (cat) =>
        files = _.filter @content_files, (f) -> f.parentDir == cat
        collections.push(new ContentCollection(files))
      deferred.resolve(collections)

    return deferred.promise

  parse_root_dir: ->
    deferred = W.defer()

    readdirp(root: @root_dir)
      .on('end', => deferred.resolve())
      .on 'data', (f) =>
        @detect(f.fullPath)
          .then((res) => if res then @content_files.push(f))

    return deferred.promise

  detect: (f) ->
    deferred = W.defer()
    res = false

    fs.createReadStream(f, {encoding: 'utf-8', start: 0, end: 3})
      .on('error', deferred.reject)
      .on('end', -> deferred.resolve(res))
      .on 'data', (data) ->
        if data.split('\n')[0] == '---' then res = true

    return deferred.promise

module.exports = ContentLoader

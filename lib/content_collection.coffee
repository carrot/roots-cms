fs = require('fs')
regex = require('../lib/regex')
Content = require('./content')

class ContentCollection
  constructor: (files) ->
    @parent_dir = files[0].parentDir
    @files = files
    @load_files()

  load_files: ->
    results = []
    @files.forEach (f) =>
      contents = fs.readFileSync(f.fullPath, 'utf8')
      order = parseInt(contents.match(regex.order)[0].substring(7))
      results.push(new Content(
        order: order
        name: f.name
        path: f.fullPath
        contents: contents
      ))

    @collection = results.sort (a, b) -> a.order - b.order

module.exports = ContentCollection

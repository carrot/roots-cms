fs = require('fs')
regex = require('../lib/regex')

module.exports = class Content
  constructor: (opts) ->
    @order = opts.order
    @name = opts.name
    @path = opts.path
    @contents = opts.contents

  save: ->
    contents = fs.readFileSync(@path, 'utf8')
    fs.open @path, 'w', (err, fd) =>
      fs.write(fd, contents.replace(regex.order, "order: #{@order}"))

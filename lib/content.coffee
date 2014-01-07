fs = require('fs')
js_yaml = require('js-yaml')
regex = require('../lib/regex')

module.exports = class Content
  constructor: (path) ->
    @matcher = /^---\s*\n([\s\S]*?)\n?---\s*\n?/
    @path = path
    @contents = fs.readFileSync(@path, 'utf8')
    @_parse()

  get: (str) -> @data[str]

  set: (attr, val) -> @data[attr] = val

  _parse: ->
    front_matter = @contents.match(@matcher)
    if not front_matter then return false
    @data = js_yaml.safeLoad(front_matter[1])

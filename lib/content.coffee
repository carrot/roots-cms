fs = require('fs')
path = require('path')
js_yaml = require('js-yaml')
config = require('../lib/config')

module.exports = class Content
  constructor: (file_path) ->
    @matcher = /^---\s*\n([\s\S]*?)\n?---\s*\n?/
    @data = {}
    @file_path = file_path
    @full_path = path.join(config.root_dir, @file_path)
    @category = path.dirname(@file_path)
    @contents = fs.readFileSync(@full_path, 'utf8')
    @parse()

  get: (str) -> @data[str]

  set: (attr, val) -> @data[attr] = val

  save: ->
    @contents = "---\n#{js_yaml.safeDump(@get('data'))}---\n"
      .concat(@get('content'))
    fs.writeFileSync(@full_path, @contents)

  parse: ->
    front_matter = @contents.match(@matcher)
    if not front_matter then return false
    @set('data', js_yaml.safeLoad(front_matter[1]))
    @set('content', @contents.replace(@matcher, ''))
    @set('id', @file_path)

  to_json: -> return @data

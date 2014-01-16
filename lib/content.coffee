fs = require('fs')
js_yaml = require('js-yaml')

module.exports = class Content
  constructor: (path, parent_dir) ->
    @matcher = /^---\s*\n([\s\S]*?)\n?---\s*\n?/
    @data = {}
    @path = path
    @parent_dir = parent_dir
    @contents = fs.readFileSync(@path, 'utf8')
    @parse()

  get: (str) -> @data[str]

  set: (attr, val) -> @data[attr] = val

  save: ->
    @contents = "---\n#{js_yaml.safeDump(@get('data'))}---\n"
      .concat(@get('content'))
    fs.writeFileSync(@path, @contents)

  parse: ->
    front_matter = @contents.match(@matcher)
    if not front_matter then return false
    @set('data', js_yaml.safeLoad(front_matter[1]))
    @set('content', @contents.replace(@matcher, ''))
    @set('meta', { @path, @parent_dir })

fs = require('fs')
js_yaml = require('js-yaml')

module.exports = class Content
  constructor: (path, parent_dir) ->
    @matcher = /^---\s*\n([\s\S]*?)\n?---\s*\n?/
    @path = path
    @parent_dir = parent_dir
    @contents = fs.readFileSync(@path, 'utf8')
    @parse()

  get: (str) -> @data[str]

  set: (attr, val) -> @data[attr] = val

  save: ->
    delete @data.roots_cms_meta
    @contents = @contents.replace(@matcher, "---\n#{js_yaml.safeDump(@data)}---\n")
    fs.writeFileSync(@path, @contents)

  parse: ->
    front_matter = @contents.match(@matcher)
    if not front_matter then return false
    @data = js_yaml.safeLoad(front_matter[1])
    @set('roots_cms_meta', { @path, @parent_dir })

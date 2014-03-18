fs = require('fs')
path = require('path')
js_yaml = require('js-yaml')
config = require('../lib/config')
Git = require('../lib/git')

module.exports = class Content
  constructor: (file_path) ->
    if path.extname(file_path) != '.md'
      file_path = file_path + '.md'

    @file_path = file_path
    @full_path = path.join(config.project_dir, config.content_dir, @file_path)

    if not fs.existsSync(@full_path)
      template_path = path.join(@full_path, '..', '_template.md')
      template = fs.readFileSync(template_path, 'utf8')
      fs.writeFileSync(path.join(@full_path), template)

    @matcher = /^---\s*\n([\s\S]*?)\n?---\s*\n?/
    @data = {}
    @category = path.dirname(@file_path)
    @contents = fs.readFileSync(@full_path, 'utf8')
    @parse()

  get: (str) -> @data[str]

  set: (attr, val) -> @data[attr] = val

  save: ->
    @contents = "---\n#{js_yaml.safeDump(@get('data'))}---\n"
      .concat(@get('content'))
    fs.writeFileSync(@full_path, @contents)

  commit: (message) ->
    Git.commit(@_changed_files(), message)

  parse: ->
    front_matter = @contents.match(@matcher)
    if not front_matter then return false
    @set('data', js_yaml.safeLoad(front_matter[1]))
    @set('content', @contents.replace(@matcher, ''))
    @set('id', @file_path)

  # returns array of changed files associated with this content
  _changed_files: ->
    files = []
    files = files.concat(@_parse_image_paths())
    files.push(path.join(config.content_dir, @file_path))
    return files

  # parses content for all local image paths and returns array of file paths
  _parse_image_paths: ->
    files = []
    matched = @contents.match /(!\[.*\]\()(.*)(\))/g
    for match in matched
      single_match = match.match /(!\[.*\]\()(\/.*)(\))/
      if single_match
        files.push(path.join('assets', single_match[2]))
    return files

  to_json: -> return @data

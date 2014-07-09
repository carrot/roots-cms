fs = require('fs')
path = require('path')
js_yaml = require('js-yaml')
Git = require('../utils/git')

module.exports = class Content
  constructor: (@cms, file_path) ->
    @config = @cms.config

    if path.extname(file_path) == ''
      file_path = file_path + '.jade'

    @file_path = file_path
    @full_path = path.join(@config.project_dir, @config.content_dir, @file_path)

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
    @set('content', @_extract_markdown(@contents))
    @set('id', @file_path)

  # returns array of changed files associated with this content
  _changed_files: ->
    files = []
    files = files.concat(@_parse_image_paths())
    files.push(path.join(@config.content_dir, @file_path))
    return files

  # parses content for all local image paths and returns array of file paths
  _parse_image_paths: ->
    files = []
    matched = @contents.match /(!\[.*\]\()(.*)(\))/g
    if matched
      for match in matched
        single_match = match.match /(!\[.*\]\()(\/.*)(\))/
        if single_match
          files.push(path.join('assets', single_match[2]))
    return files

  _extract_markdown: (contents) ->
    # removes front matter, jade syntax, and indentation
    below_front_matter = contents.replace(@matcher, '')
    jade_syntax = below_front_matter.match(/.*\s( *):markdown\n/)
    markdown_indent_length = jade_syntax[1].length + 2
    split = below_front_matter.split(':markdown')
    split.shift()
    content = split.join('').replace(///\n#{Array(markdown_indent_length + 1).join(' ')}///g, '\n')
    if content[0] == '\n' then content = content.substr(1)
    return content

  to_json: -> return @data

fs = require('fs')
path = require('path')
js_yaml = require('js-yaml')
Git = require('../utils/git')

module.exports = class Content
  matcher: /^---\s*\n([\s\S]*?)\n?---\s*\n?/
  data: {}

  constructor: (@cms, file_path) ->
    load_file_metadata.call(@, file_path)
    if not fs.existsSync(@full_path) then create_from_template(@full_path)
    @raw = fs.readFileSync(@full_path, 'utf8')
    @parse()

  get: (str) -> @data[str]

  set: (attr, val) -> @data[attr] = val

  save: ->
    @raw = "---\n#{js_yaml.safeDump(@get('data'))}---\n"
      .concat("extends ../_single\nblock content\n  :markdown\n    #{@get('content').replace(/\n/g, '\n    ')}")
    fs.writeFileSync(@full_path, @raw)

  commit: (message) ->
    Git.commit(@_changed_files(), message)

  parse: ->
    front_matter = @raw.match(@matcher)
    if not front_matter then return false
    @set('data', js_yaml.safeLoad(front_matter[1]))
    @set('content', @_extract_markdown(@raw))
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
    matched = @raw.match /(!\[.*\]\()(.*)(\))/g
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
    if not jade_syntax then return ''
    markdown_indent_length = jade_syntax[1].length + 2
    split = below_front_matter.split(':markdown')
    split.shift()
    content = split.join('').replace(///\n#{Array(markdown_indent_length + 1).join(' ')}///g, '\n')
    if content[0] == '\n' then content = content.substr(1)
    return content

  to_json: -> return @data

  load_file_metadata = (p) ->
    if path.extname(p) == ''
      jade = p + '.jade'
      md   = p + '.md'
      if fs.existsSync(@cms.abs_path(jade))
        p = jade
      else if fs.existsSync(@cms.abs_path(md))
        p = md
    @file_path = p
    @full_path = @cms.abs_path(@file_path)
    @category  = path.dirname(@file_path)

  create_from_template = (p) ->
    template_path = path.join(p, '..', '_template.md')
    template = fs.readFileSync(template_path, 'utf8')
    fs.writeFileSync(path.join(p), template)

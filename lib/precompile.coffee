fs = require('fs')
path = require('path')
jade = require('jade')
config = require('./config')

module.exports = ->
  src_dir = path.join(__dirname, '..', 'assets', 'js', 'templates')
  dest_file = path.join(__dirname, '..', 'public', 'js', 'templates.js')

  files = fs.readdirSync(src_dir)
  templates = []

  for key, file_path of config.templates
    templates[key] = jade.compile fs.readFileSync(file_path, 'utf8'),
      debug: false
      compileDebug: true
      filename: file_path
      client: true

  properties = []

  for k, v of templates
    properties.push("#{JSON.stringify(k)}:\n #{v.toString()}")

  source_code = "define(['vendor/jade_runtime'], function(jade) {\n return {\n#{properties.join(',\n\n')}\n};\n});"

  fs.writeFileSync(dest_file, source_code)

fs = require('fs')
path = require('path')
jade = require('jade')
config = require('./config')

module.exports = ->
  # precompile templates

  templates = []

  for key, file_path of config.templates
    file = fs.readFileSync(file_path, 'utf8')
    templates[key] = jade.compile file,
      debug: false
      compileDebug: true
      client: true

  properties = []

  for k, v of templates
    properties.push("#{JSON.stringify(k)}:\n #{v.toString()}")

  source_code = "define(['vendor/jade_runtime'], function(jade) {\n return {\n#{properties.join(',\n\n')}\n};\n});"

  fs.writeFileSync(path.join(__dirname, '..', 'public', 'js', 'templates.js'), source_code)

  # copy custom stylesheets over
  if config.css then css_path = path.join(config.project_dir, config.css)
  if css_path && fs.existsSync(css_path)
    custom_css = fs.readFileSync(css_path, 'utf8')
    fs.writeFileSync(path.join(__dirname, '..', 'assets', 'css', 'custom.styl'), custom_css)

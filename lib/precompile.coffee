fs = require('fs')
path = require('path')
jade = require('jade')

module.exports = ->
  src_dir = path.join(__dirname, '..', 'assets', 'js', 'templates')
  dest_file = path.join(__dirname, '..', 'public', 'js', 'templates.js')

  files = fs.readdirSync(src_dir)
  templates = []

  for file in files
    if /\.jade$/.test(file)
      name = path.basename(file, ".jade")
      file_path = path.join(src_dir, file)
      contents = fs.readFileSync(file_path, encoding: "utf8")

      templates[name] = jade.compile contents,
        debug: false
        compileDebug: true
        filename: file_path
        client: true

  properties = []

  for k, v of templates
    properties.push("#{JSON.stringify(k)}:\n #{v.toString()}")

  source_code = "define(['vendor/jade_runtime'], function(jade) {\n return {\n#{properties.join(',\n\n')}\n};\n});"

  fs.writeFileSync(dest_file, source_code)

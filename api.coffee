require('coffee-script')
express = require('express')
path = require('path')
fs = require('fs')
config = require('./lib/config')
Category = require('./lib/category')
Content = require('./lib/content')

module.exports = api = express()

api.get '/api/categories', (req, res) ->
  Category.all(path.join(config.project_dir, config.content_dir))
    .then (category_json) -> res.json(category_json)

api.get '/api/content/:path', (req, res) ->
  res.json((new Content(req.params.path)).to_json())

api.put '/api/content/:path', (req, res) ->
  content = new Content(req.body.id)
  content.set('data', req.body.data)
  content.set('content', req.body.content)
  content.save()

  res.send('success')

api.post '/api/upload_image', (req, res) ->
  fs.readFile req.files.file.path, (err, data) ->
    file_name = "img_#{(new Date).getTime()}.png"
    dest_path = path.join(config.project_dir, 'assets', 'img', 'uploads', file_name)

    fs.writeFile dest_path, data, (err) ->
      res.send('success')

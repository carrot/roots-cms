require('coffee-script')
express = require('express')
path = require('path')
fs = require('fs')
config = require('./lib/config')
Category = require('./lib/category')
Content = require('./lib/content')
Uploader = require('./lib/uploader')

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

api.post '/api/commit', (req, res) ->
  id      = req.body.id
  message = req.body.message
  if message.length == 0 
    message = "update #{id}"

  content = new Content(id)
  content.commit(message)
  res.send(message)

api.post '/api/upload_image', (req, res) ->
  Uploader.init().upload(req.files.file.path)
    .then (url) -> res.json(url: url)

require('coffee-script')
express = require('express')
path = require('path')
ContentLoader = require('./lib/content_loader')
Category = require('./lib/category')
Content = require('./lib/content')

module.exports = api = express()

api.get '/api/categories', (req, res) ->
  ContentLoader.all(process.cwd())
    .then (content) -> res.json(Category.sort(content))

api.get '/api/content/:path', (req, res) ->
  file_path = req.params.path
  content = new Content(path.join(process.cwd(), file_path), file_path)
  res.json(content.data)

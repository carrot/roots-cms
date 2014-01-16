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

api.put '/api/content/:path', (req, res) ->
  file_path = req.body.meta.parent_dir

  content = new Content(path.join(process.cwd(), file_path), file_path)
  content.set('data', req.body.data)
  content.set('content', req.body.content)
  content.save()

  res.write('success')

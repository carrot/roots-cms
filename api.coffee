require('coffee-script')
express = require('express')
path = require('path')
config = require('./config')
ContentLoader = require('./lib/content_loader')
Category = require('./lib/category')
Content = require('./lib/content')

module.exports = api = express()

api.get '/api/categories', (req, res) ->
  ContentLoader.all(config.root_dir)
    .then (content) -> res.json(Category.sort(content))

api.get '/api/content/:path', (req, res) ->
  res.json((new Content(req.params.path)).to_json())

api.put '/api/content/:path', (req, res) ->
  content = new Content(req.body.id)
  content.set('data', req.body.data)
  content.set('content', req.body.content)
  content.save()

  res.send('success')

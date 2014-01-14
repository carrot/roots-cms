require('coffee-script')
express = require('express')
ContentLoader = require('./lib/content_loader')
Category = require('./lib/category')

module.exports = api = express()

api.get '/api/categories', (req, res) ->
  ContentLoader.all(process.cwd())
    .then (content) -> res.json(Category.sort(content))

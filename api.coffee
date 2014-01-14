require('coffee-script')
express = require('express')
ContentLoader = require('./lib/content_loader')

module.exports = api = express()

api.get '/api/content', (req, res) ->
  ContentLoader.all(process.cwd()).then (content) -> res.json(content)

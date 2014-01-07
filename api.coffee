require('coffee-script')
express = require('express')
ContentLoader = require('./lib/content_loader')

module.exports = api = express()

api.get 'api/content', (req, res) ->
  ContentLoader.detect process.cwd(), (err, files) ->
    content = ContentLoader.load(files)
    res.json(content)

express = require('express')
Content = require('./lib/content')
ContentLoader = require('./lib/content_loader')

app = module.exports = express()

app.get '/api', (req, res) ->
  new ContentLoader().load_collections().then (collections) ->
    res.json(collections)

app.post '/api', (req, res) ->
  req.body.collection.forEach (c) ->
    content = new Content
      order: c.order
      name: c.name
      path: c.path
      contents: c.contents

    content.save()

  res.json('status': 'ok')

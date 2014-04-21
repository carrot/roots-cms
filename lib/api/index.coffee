express = require('express')
path = require('path')
fs = require('fs')
Category = require('../category')
Content = require('../content')
Uploader = require('../uploader')

module.exports = (@cms, server) ->
  config = @cms.config

  server.get '/api/categories.json', (req, res) ->
    @cms.all().then (category_json) ->
      res.json(category_json)

  server.get '/api/content/:path.json', (req, res) ->
    res.json(@cms.find_content(req.params.path).to_json())

  server.put '/api/content/:path', (req, res) ->
    @cms.update_content(req.body.id, req.body.data, req.body.content)
    res.send('success')

  server.post '/api/commit', (req, res) ->
    id      = req.body.id
    message = req.body.message
    if message.length == 0
      message = "update #{id}"

    content = new Content(@cms, id)
    content.commit(message)
    res.send(message)

  server.post '/api/upload_image', (req, res) ->
    (new Uploader(@cms)).upload(req.files.file.path)
      .then (url) -> res.json(url: url)

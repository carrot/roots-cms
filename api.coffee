require('coffee-script')
express = require('express')
path = require('path')
fs = require('fs')
config = require('./lib/config')
Category = require('./lib/category')
Content = require('./lib/content')
aws_client = require('./lib/aws_client')

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
  fs.readFile req.files.file.path, (err, buf) ->
    file_name = "img_#{(new Date).getTime()}.png"

    req = aws_client.put "/uploads/#{file_name}",
      'Content-Length': buf.length
      'Content-Type': 'image/jpg'
      'x-amz-acl': 'public-read'

    req.on 'response', (aws_res) ->
      if 200 == aws_res.statusCode
        console.log('saved to %s', req.url)

      res.json({url: req.url})

    req.end(buf)

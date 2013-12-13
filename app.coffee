express = require('express')
stylus = require('stylus')
axis = require('axis-css')
coffeescript = require('connect-coffee-script')
open = require('open')

app = express()

app.set('views', "#{__dirname}/views")
app.set('view engine', 'jade')
app.use(express.logger('dev'))

app.use stylus.middleware(
  src: __dirname + '/assets'
  dest: __dirname + '/public'
  compile: (str, path) -> stylus(str).set('filename', path).use(axis())
)

app.use coffeescript(
  src: __dirname + '/assets'
  dest: __dirname + '/public'
)


app.use(express.bodyParser())
app.use(express.static("#{__dirname}/public"))

app.get "/", (req, res) ->
  res.render 'index'

api = require('./api')
app.use(api)

app.listen(3000)
open('http://localhost:3000')

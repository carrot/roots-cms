express = require('express')
stylus = require('stylus')
axis = require('axis-css')
coffeescript = require('connect-coffee-script')
require('./lib/precompile')()

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

[user, password] = [process.env.USER, process.env.PASSWORD]
if user && password
  app.use(express.basicAuth(process.env.USER, process.env.PASSWORD))

app.use(require('./api'))

app.get "*", (req, res) ->
  res.render 'index'

app.listen(process.env.PORT || 2222)

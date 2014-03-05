express = require('express')
path = require('path')
stylus = require('stylus')
axis = require('axis-css')
grate = require('grate')
coffeescript = require('connect-coffee-script')
config = require('./lib/config')
require('./lib/precompile')()

app = express()

app.set('views', "#{__dirname}/views")
app.set('view engine', 'jade')
app.use(express.logger('dev'))

app.use stylus.middleware(
  src: __dirname + '/assets'
  dest: __dirname + '/public'
  compile: (str, path) -> stylus(str).set('filename', path).use(axis()).use(grate())
)

app.use coffeescript(
  src: __dirname + '/assets'
  dest: __dirname + '/public'
)

# allow express to parse body params
app.use(express.bodyParser())

# serve assets for roots-cms
app.use(express.static("#{__dirname}/public"))

# serve assets for the roots project
app.use(express.static(path.join(config.project_dir, 'assets')))

# set up basic auth if enabled
if config.basic_auth
  app.use(express.basicAuth(config.basic_auth.username, config.basic_auth.password))

# load the api
app.use(require('./api'))

# respond to all other requests with the marionette SPA
app.get "*", (req, res) ->
  res.render 'index'

app.listen(process.env.PORT || 2222)

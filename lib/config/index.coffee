path  = require 'path'
fs    = require 'fs'

class Config
  @defaults:
    content_dir: ''
    auth: false
    templates:
      content_edit: path.join(__dirname, 'server', 'assets', 'templates', 'content_edit.jade')
      category: path.join(__dirname, 'server', 'assets', 'templates', 'category.jade')
      post: path.join(__dirname, 'server', 'assets', 'templates', 'post.jade')
      posts: path.join(__dirname, 'server',  'assets', 'templates', 'posts.jade')
    aws: null
    uploader: 'fs'
    img_upload_dir: 'uploads'
    env: 'development'
    port: parseInt(process.env.PORT) || 2222

  constructor: (@cms, opts) ->
    if not @cms then throw Error 'no cms object given to configure'
    set_defaults.call(@)
    load_config.call(@)
    set_config.call(@, opts)

  set_defaults = ->
    @project_dir = @cms.root || process.cwd()
    set_config.call(@, Config.defaults)

  load_config = ->
    root_path   = @cms.root
    config_path = path.join(root_path, 'cms.json')

    if fs.existsSync(config_path)
      config = require(config_path)
      for k, v of config.templates
        config.templates[k] = path.join(root_path, v)
      set_config.call(@, config)

  set_config = (config) ->
    @[k] = v for k, v of config

module.exports = Config

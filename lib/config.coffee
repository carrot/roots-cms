path = require('path')
_ = require('lodash')

try
  config = require('../config')
catch
  config = null

defaults =
  project_dir: config?.project_dir || process.cwd()
  content_dir: ''
  basic_auth: false
  templates:
    content_edit: path.join(__dirname, '..', 'assets', 'templates', 'content_edit.jade')
    category: path.join(__dirname, '..', 'assets', 'templates', 'category.jade')
    post: path.join(__dirname, '..', 'assets', 'templates', 'post.jade')
    posts: path.join(__dirname, '..', 'assets', 'templates', 'posts.jade')
  aws: null

# attempt to load custom config from project
try
  custom = require(path.join(defaults.project_dir, 'cms'))

  # convert custom template paths to their absolute path
  for k, v of custom.templates
    custom.templates[k] = path.join(defaults.project_dir, v)

  options = _.merge(defaults, custom)
catch
  options = defaults

module.exports = options
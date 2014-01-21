path = require('path')
merge = require('deepmerge')

defaults =
  project_dir: require('../config').project_dir || process.cwd()
  content_dir: ''
  basic_auth: false
  username: 'admin'
  password: 'password'
  templates:
    content_show: path.join(__dirname, '..', 'assets', 'templates', 'content_show.jade')
    category: path.join(__dirname, '..', 'assets', 'templates', 'category.jade')
    post: path.join(__dirname, '..', 'assets', 'templates', 'post.jade')

custom = require(path.join(defaults.project_dir, 'cms'))

# convert custom template paths to their absolute path
for k, v of custom.templates
  custom.templates[k] = path.join(defaults.project_dir, v)

options = merge(defaults, custom)

module.exports = options

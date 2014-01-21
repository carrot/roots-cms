path = require('path')
merge = require('deepmerge')

defaults =
  project_dir: require('../config').project_dir || process.cwd()
  root_dir: ''
  basic_auth: false
  username: 'admin'
  password: 'password'
  templates:
    content_show: path.join(__dirname, '..', 'assets/js/templates/content_show.jade')
    category: path.join(__dirname, '..', 'assets/js/templates/category.jade')
    post: path.join(__dirname, '..', 'assets/js/templates/post.jade')

custom = require(path.join(defaults.project_dir, 'cms'))
options = merge(defaults, custom)

module.exports = options

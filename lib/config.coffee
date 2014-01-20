path = require('path')
merge = require('deepmerge')

defaults =
  project_dir: require('../config').project_dir || process.cwd()
  root_dir: ''
  basic_auth: false
  username: 'admin'
  password: 'password'
  templates:
    content_show: 'assets/js/templates/content_show.jade'
    category: 'assets/js/templates/category.jade'

custom = require(path.join(defaults.project_dir, 'cms'))
options = merge(defaults, custom)

module.exports = options

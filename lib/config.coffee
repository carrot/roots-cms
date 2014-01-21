path = require('path')
merge = require('deepmerge')

defaults =
  project_dir: require('../config').project_dir || process.cwd()
  content_dir: ''
  basic_auth: false
  username: 'admin'
  password: 'password'
  templates:
    content_show: 'assets/templates/content_show.jade'
    category: 'assets/templates/category.jade'
    post: 'assets/templates/post.jade'

custom = require(path.join(defaults.project_dir, 'cms'))

# convert custom template paths to their absolute path
for k, v of custom.templates
  custom.templates[k] = path.join(defaults.project_dir, v)

options = merge(defaults, custom)

module.exports = options

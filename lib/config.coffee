path = require('path')

# default config
options =
  root_dir: ''
  basic_auth: false
  username: 'admin'
  password: 'password'

project = require('../config').project

for k, v of require(path.join(project, 'cms'))
  options[k] = v

module.exports = options

shell = require('shelljs')

module.exports = class Git
  constructor: ->
    if not shell.which 'git'
      shell.echo 'Sorry, git does not appear to be installed'
      shell.exit 1

  commit: (files, message) ->
    for file in files
      shell.exec "git add #{file}"

    shell.exec "git commit -m \"#{message}\""

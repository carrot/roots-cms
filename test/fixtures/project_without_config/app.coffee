axis         = require 'axis-css'
autoprefixer = require 'autoprefixer-stylus'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore']

  stylus:
    use: [axis(), autoprefixer()]

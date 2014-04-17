axis            = require 'axis-css'
autoprefixer    = require 'autoprefixer-stylus'
ClientTemplates = require 'client-templates'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore']

  stylus:
    use: [axis(), autoprefixer()]

  extensions: [
    ClientTemplates
      base: 'templates/'
      pattern: '*.jade'
  ]

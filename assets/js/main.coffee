require.config
  shim:
    underscore: { exports: '_' }
    backbone: { deps: ['jquery', 'underscore'], exports: 'Backbone' }
    backbone_relational: { deps: ['backbone'] }
    marionette: { deps: ['backbone'], exports: 'Marionette' }

  paths:
    app: 'application'
    backbone: 'vendor/backbone'
    backbone_relational: 'vendor/backbone-relational'
    jquery: 'vendor/jquery'
    jqueryui: 'vendor/jqueryui'
    marionette: 'vendor/backbone.marionette'
    underscore: 'vendor/underscore'

require ['app', 'marionette', 'router', 'controller'], (App, Marionette, Router, Controller) ->

  App.on 'initialize:after', ->
    router = new Router(controller: new Controller)
    Backbone.history.start()

  App.start()

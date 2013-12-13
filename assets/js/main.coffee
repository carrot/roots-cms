require.config
  shim:
    underscore: { exports: '_' }
    backbone: { deps: ['jquery', 'underscore'], exports: 'Backbone' }
    marionette: { deps: ['backbone'], exports: 'Marionette' }

  paths:
    backbone: ['vendor/backbone']
    jquery: ['vendor/jquery']
    jqueryui: ['vendor/jqueryui']
    marionette: ['vendor/backbone.marionette']
    underscore: ['vendor/underscore']

require ['collections/content', 'views/content_collection'], (ContentCollection, ContentCollectionView) ->
  App = new Marionette.Application()

  App.on 'initialize:after', ->
    $.ajax
      url: '/api'
      type: "GET"
      success: (data) ->
        data.forEach (c) ->
          view = new ContentCollectionView
            collection: new ContentCollection(c.collection, parent_dir: c.parent_dir)
          $('#content').append(view.render().$el)
      error: (data, message) -> console?.log? data, message

  App.start()

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

  App.addRegions
    content: '#content'

  App.on 'initialize:after', ->
    collection = new ContentCollection
    collection.fetch
      success: (collection, res, opts) ->
        App.content.show(new ContentCollectionView(collection: collection))
      fail: (collection, res, opts) -> console?.log?(collection, res, opts)

  App.start()

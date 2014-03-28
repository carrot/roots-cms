define ['marionette'], (Marionette) ->
  App = new Marionette.Application()

  App.addRegions
    content: '#content'

  return App

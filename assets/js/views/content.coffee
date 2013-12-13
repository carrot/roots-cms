define ['marionette', 'jqueryui'], (Marionette) ->
  class ContentView extends Marionette.ItemView
    template: '#content-item'
    tagName: 'li'

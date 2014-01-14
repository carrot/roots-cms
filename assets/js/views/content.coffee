define ['marionette', 'jqueryui'], (Marionette) ->
  class ContentView extends Marionette.ItemView
    template: '#content-item'
    tagName: 'li'

    templateHelpers: ->
      path: ->
        @roots_cms_meta['path'].split('/').reverse()[0]

    meta: (key) -> console.log(@.meta)

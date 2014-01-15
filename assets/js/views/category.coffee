define ['marionette', 'jqueryui'], (Marionette) ->
  class Category extends Marionette.ItemView
    template: '#category'
    tagName: 'li'

    # templateHelpers: ->
      # path: ->
        # @roots_cms_meta['path'].split('/').reverse()[0]

    # meta: (key) -> console.log(@.meta)

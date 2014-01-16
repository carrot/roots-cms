define ['marionette', 'templates', 'jqueryui'], (Marionette, templates) ->
  class Category extends Marionette.ItemView
    template: templates.category
    tagName: 'li'

    # templateHelpers: ->
      # path: ->
        # @roots_cms_meta['path'].split('/').reverse()[0]

    # meta: (key) -> console.log(@.meta)

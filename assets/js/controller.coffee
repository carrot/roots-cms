define ['app', 'marionette', 'collections/categories', 'views/categories'], (App, Marionette, Categories, CategoriesView) ->
  class Controller extends Marionette.Controller
    show_categories: ->
      (new Categories).fetch
        success: (collection, res, opts) ->
          App.content.show(new CategoriesView(collection: collection))
        fail: (collection, res, opts) -> console?.log?(collection, res, opts)

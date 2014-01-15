define ['app', 'marionette', 'collections/categories', 'models/content', 'views/categories'], (App, Marionette, Categories, Content, CategoriesView) ->
  class Controller extends Marionette.Controller
    list_categories: ->
      (new Categories).fetch
        success: (collection, res, opts) ->
          App.content.show(new CategoriesView(collection: collection))
        fail: (collection, res, opts) -> console?.log?(collection, res, opts)

    show_content: (path) ->
      content = new Content(id: path)
      console.log(content.url())
      content.fetch
        success: (model, res, opts) -> console.log(model)
        fail: (model, res, opts) -> console.log(model, res, opts)

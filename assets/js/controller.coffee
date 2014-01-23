define ['app', 'marionette', 'collections/categories', 'models/content', 'views/categories', 'views/content_edit', 'views/posts'], (App, Marionette, Categories, Content, CategoriesView, ContentEditView, PostsView) ->
  class Controller extends Marionette.Controller
    list_categories: ->
      (new Categories).fetch
        success: (collection, res, opts) ->
          App.content.show(new CategoriesView(collection: collection))
        fail: (collection, res, opts) -> console?.log?(collection, res, opts)

    edit_content: (path) ->
      # Find cached model in Backbone Relational store if exists
      if model = Content.findOrCreate(path)
        return App.content.show(new ContentEditView(model: model))

      (new Content(id: path)).fetch
        success: (model, res, opts) ->
          App.content.show(new ContentEditView(model: model))
        fail: (model, res, opts) -> console.log(model, res, opts)

    list_posts: (folder) ->
      (new Categories).fetch
        success: (collection, res, opts) ->
          category = collection.find (m) -> m.get('name') == folder
          posts = category.get('content')
          App.content.show(new PostsView(collection: posts))
        fail: (model, res, opts) -> console.log(model, res, opts)

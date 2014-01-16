define ['app', 'marionette'], (App, Marionette) ->
  class Router extends Marionette.AppRouter
    appRoutes:
      '': 'list_categories'
      'posts/*folder': 'list_posts'
      'content/*path': 'show_content'

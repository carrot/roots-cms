define ['app', 'marionette'], (App, Marionette) ->
  class Router extends Marionette.AppRouter
    appRoutes:
      '': 'list_categories'
      'category/*folder': 'list_posts'
      'content/*path': 'show_content'

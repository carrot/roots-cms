define ['app', 'marionette'], (App, Marionette) ->
  class Router extends Marionette.AppRouter
    appRoutes:
      '': 'list_categories'
      'content/*path': 'show_content'

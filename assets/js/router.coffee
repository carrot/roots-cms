define ['app', 'marionette'], (App, Marionette) ->
  class Router extends Marionette.AppRouter
    appRoutes:
      '': 'show_categories'

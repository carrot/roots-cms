define ['app', 'marionette', 'templates', 'jqueryui'], (App, Marionette, templates) ->
  class Category extends Marionette.ItemView
    template: templates.category
    tagName: 'li'

    events:
      'click': 'path'

    path: ->
      path = 'category/' + @model.get('name')
      App.request('router').navigate(path, {trigger: true})

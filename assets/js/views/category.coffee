define ['marionette', 'templates', 'jqueryui'], (Marionette, templates) ->
  class Category extends Marionette.ItemView
    template: templates.category
    tagName: 'li'

    events:
      'click': 'path'

    path: ->
      folder = @model.get('name')
      console.log 'posts/' + folder
      # App.request('router').navigate(path)


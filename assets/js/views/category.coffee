define ['app', 'marionette', 'templates', 'jqueryui'], (App, Marionette, templates) ->
  class Category extends Marionette.ItemView
    template: templates.category
    tagName: 'li'
    
    ui:
      'path': 'input'

    events:
      'click .category': 'path'
      'click .new': 'new_content'

    path: ->
      path = 'category/' + @model.get('name')
      App.request('router').navigate(path, {trigger: true})

    new_content: ->
      path = "content/#{@model.get('name')}/#{@ui.path.val()}"
      if path.split('.').reverse()[0] != 'md'
        path = path + '.md'
      App.request('router').navigate(path, {trigger: true})

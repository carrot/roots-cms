define ['app', 'marionette', 'templates', 'jqueryui'], (App, Marionette, templates) ->
  class PostView extends Marionette.ItemView
    template: templates.post
    tagName: 'li'

    events:
      'click': 'path'

    path: ->
      path = 'content/' + @model.get('id')
      App.request('router').navigate(path, {trigger: true})

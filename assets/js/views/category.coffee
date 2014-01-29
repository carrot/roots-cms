define ['app', 'marionette', 'templates', 'jqueryui', 'modal'], (App, Marionette, templates) ->
  class Category extends Marionette.ItemView
    template: templates.category
    tagName: 'li'
    
    ui:
      'path': 'input'
      'modal': '.modal'

    events:
      'click .category': 'path'
      'click .new': 'new_content'
      'click .create': 'create_content'
      'click .close': 'close_modal'

    path: ->
      path = 'category/' + @model.get('name')
      App.request('router').navigate(path, {trigger: true})

    new_content: ->
      @ui.modal.trigger('openModal')

    create_content: ->
      path = "content/#{@model.get('name')}/#{@ui.path.val()}"
      if path.split('.').reverse()[0] != 'md'
        path = path + '.md'
      App.request('router').navigate(path, {trigger: true})

    close_modal: ->
      @ui.modal.trigger('closeModal')

    onRender: ->
      @ui.modal.easyModal()

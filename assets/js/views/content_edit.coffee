define ['marionette', 'templates', 'underscore', 'marked', 'pen', 'html_md', 'pen_markdown'], (Marionette, templates, _, marked, Pen, md) ->
  class ContentEdit extends Marionette.ItemView
    template: templates.content_edit

    ui:
      'content': '.contents'
      'data': '.data input'
      'back': '.back'

    events:
      'click button': 'save'
      'click .back': 'go_back'

    templateHelpers: ->
      content_to_html: (-> marked(@model.get('content'))).bind(@)
      category: (-> @category_display()).bind(@)

    onRender: ->
      new Pen(@ui.content[0])

    get_data: ->
      _.reduce @ui.data, (data, el) ->
        data[$(el).attr('name')] = $(el).val()
        return data
      , {}

    category_display: ->
      cats = @model.get('id').split('/')
      cats.pop()
      cats.join('/')

    save: ->
      modified_content = md(@ui.content.html())
      @model.set('content', modified_content)
      @model.set('data', @get_data())
      @model.save()
      @render()

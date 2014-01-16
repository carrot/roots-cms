define ['marionette', 'templates', 'marked', 'pen', 'html_md', 'pen_markdown'], (Marionette, templates, marked, Pen, md) ->
  class ContentShow extends Marionette.ItemView
    template: templates.content_show

    ui:
      'content_area': '.content-area'

    events:
      'click button': 'save'

    templateHelpers: ->
      content_to_html: (-> marked(@model.get('content'))).bind(@)

    onRender: ->
      new Pen(@ui.content_area[0])

    save: ->
      modified_content = md(@ui.content_area.html())
      @model.set('content', modified_content)
      @model.save()

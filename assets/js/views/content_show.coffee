define ['marionette', 'marked', 'pen', 'html_md', 'pen_markdown'], (Marionette, marked, Pen, md) ->
  class ContentShow extends Marionette.ItemView
    template: '#content-show'

    ui:
      'content_area': '.content-area'

    events:
      'click button': 'save'

    templateHelpers: ->
      markdownContent: ->
        marked(@content)

    onRender: ->
      new Pen(@ui.content_area[0])

    save: ->
      modified_content = md(@ui.content_area.html())
      @model.set('content', modified_content)
      @model.save()

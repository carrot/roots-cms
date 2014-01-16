define ['marionette', 'marked', 'pen', 'html_md', 'pen_markdown', ], (Marionette, marked, Pen, md) ->
  class ContentShow extends Marionette.ItemView
    template: '#content-show'
    id: 'content_show'

    events:
      'click button': 'save'

    templateHelpers: ->
      markdownContent: ->
        marked(@content)

    onRender: ->
      new Pen(@el)

    save: ->
      modified_content = md(@el.innerHTML)
      @model.set('content', modified_content)

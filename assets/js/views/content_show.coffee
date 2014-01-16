define ['marionette', 'marked', 'pen', 'pen_markdown'], (Marionette, marked, Pen) ->
  class ContentShow extends Marionette.ItemView
    template: '#content-show'
    id: 'content_show'

    templateHelpers: ->
      markdownContent: ->
        marked(@content)

    onRender: ->
      new Pen(@el)

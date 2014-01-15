define ['marionette', 'pen', 'markdown'], (Marionette, Pen) ->
  class ContentShow extends Marionette.ItemView
    template: '#content-show'

    onRender: ->
      new Pen("#content")

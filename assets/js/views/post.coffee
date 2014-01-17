define ['marionette', 'templates', 'jqueryui'], (Marionette, templates) ->
  class PostView extends Marionette.ItemView
    template: templates.post
    tagName: 'li'

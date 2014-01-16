define ['marionette', 'templates', 'jqueryui'], (Marionette, templates) ->
  class PostView extends Marionette.ItemView
    template: templates.posts
    tagName: 'li'

    templateHelpers: ->
      test: ->
        @content

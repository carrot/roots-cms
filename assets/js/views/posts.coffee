define ['marionette', 'views/post', 'jquery', 'templates', 'jqueryui'], (Marionette, PostView, $, templates) ->
  class PostsView extends Marionette.CompositeView
    template: templates.posts
    itemViewContainer: 'ul'
    itemView: PostView

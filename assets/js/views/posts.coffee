define ['marionette', 'views/post', 'jquery', 'jqueryui'], (Marionette, PostView, $) ->
  class PostsView extends Marionette.CollectionView
    template: '#posts'
    tagName: 'ul'
    itemView: PostView

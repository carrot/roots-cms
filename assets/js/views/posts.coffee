define ['marionette', 'views/post', 'jquery', 'jqueryui'], (Marionette, PostView, $) ->
  class PostsView extends Marionette.CollectionView
    template: '#posts'
    tagName: 'ul'
    itemView: PostView



    # onRender: ->
    #   console.log 'post collection view'

    # templateHelpers: ->
    #   parent_dir: @collection.parent_dir

    # onRender: ->
    #   @$el.sortable
    #     update: => @resort()

    # resort: ->
    #   for key, view of @children._views
    #     view.model.set('order', view.$el.index())
    #   @collection.sort().save()
    #   @render()

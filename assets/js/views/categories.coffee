define ['marionette', 'views/category', 'jquery', 'jqueryui'], (Marionette, CategoryView, $) ->
  class ContentCollectionView extends Marionette.CollectionView
    template: '#categories'
    tagName: 'ul'
    itemView: CategoryView

    # templateHelpers: ->
      # parent_dir: @collection.parent_dir

    # onRender: ->
      # @$el.sortable
        # update: => @resort()

    # resort: ->
      # for key, view of @children._views
        # view.model.set('order', view.$el.index())
      # @collection.sort().save()
      # @render()

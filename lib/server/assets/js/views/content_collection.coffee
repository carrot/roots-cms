define ['marionette', 'views/content', 'jquery', 'jqueryui'], (Marionette, ContentView, $) ->
  class ContentCollectionView extends Marionette.CompositeView
    template: '#content-collection'
    tagName: 'ul'
    itemView: ContentView

    templateHelpers: ->
      parent_dir: @collection.parent_dir

    onRender: ->
      @$el.sortable
        update: => @resort()

    resort: ->
      for key, view of @children._views
        view.model.set('order', view.$el.index())
      @collection.sort().save()
      @render()

define ['marionette', 'views/category', 'jquery', 'jqueryui'], (Marionette, CategoryView, $) ->
  class ContentCollectionView extends Marionette.CollectionView
    template: '#categories'
    tagName: 'ul'
    itemView: CategoryView

define ['jquery', 'models/category'], ($, Category) ->
  class Categories extends Backbone.Collection
    model: Category
    url: '/api/categories'

    comparator: (m) -> m.get('order')

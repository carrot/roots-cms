define ['jquery', 'models/content'], ($, Content) ->
  class ContentCollection extends Backbone.Collection
    model: Content
    url: '/api/content'

    comparator: (m) -> m.get('order')

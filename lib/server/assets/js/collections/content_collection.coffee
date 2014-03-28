define ['jquery', 'models/content', 'backbone_relational'], ($, Content) ->
  class ContentCollection extends Backbone.RelationalModel
    model: Content
    url: '/api/content'

    comparator: (m) -> m.get('order')

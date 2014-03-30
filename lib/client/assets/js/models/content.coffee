define ['backbone', 'backbone_relational'], (Backbone) ->
  class Content extends Backbone.RelationalModel
    urlRoot: '/api/content'

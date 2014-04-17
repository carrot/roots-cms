define ['backbone', 'collections/content_collection', 'models/content', 'backbone_relational'], (Backbone, ContentCollection, Content) ->
  class Category extends Backbone.RelationalModel
    relations: [
      type: Backbone.HasMany
      key: 'content'
      relatedModel: Content
    ]

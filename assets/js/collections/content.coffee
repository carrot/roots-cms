define ['jquery', 'models/content'], ($, Content) ->
  class ContentCollection extends Backbone.Collection
    model: Content
    url: '/api'

    initialize: (models, opts) ->
      @parent_dir = opts.parent_dir

    comparator: (m) -> m.get('order')

    save: ->
      $.ajax
        url: @url
        type: "POST"
        data:
          collection: @models.map (m) -> m.toJSON()
        success: (data) -> console?.log? data
        error: (data, message) -> console?.log? data, message

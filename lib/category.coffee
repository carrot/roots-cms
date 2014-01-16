path = require('path')
W = require('when')

module.exports =
  sort: (content) ->
    grouped = @_group_by_category(content)
    categories = @_to_json(grouped)

  _group_by_category: (content) ->
    grouped = []

    for c in content
      key = c.category
      if not grouped[key]? then grouped[key] = []
      grouped[key].push(c)

    return grouped

  _to_json: (grouped) ->
    categories = []

    for key, content_array of grouped
      json = (c.to_json() for c in content_array)
      category = { name: key, content: json }
      categories.push(category)

    return categories

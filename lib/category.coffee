W = require('when')

module.exports =
  sort: (content) ->
    grouped = @_group_content_by_category(content)
    categories = @_to_json(grouped)

  _group_content_by_category: (content) ->
    grouped = []

    for c in content
      key = c.roots_cms_meta.parent_dir
      if not grouped[key]? then grouped[key] = []
      grouped[key].push(c)

    return grouped

  _to_json: (grouped) ->
    categories = []

    for k, v of grouped
      category = { name: k, content: v }
      categories.push(category)

    return categories

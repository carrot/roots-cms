fs = require('fs')
path = require('path')
Content = require('../content')

module.exports =
  by_category: (@cms, content) ->
    @config = @cms.config
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

      category = {}

      template_path = path.join(key, '_template.md')
      if fs.existsSync(path.join(@config.project_dir, @config.content_dir, template_path))
        template = new Content(@cms, template_path)
        template.set('id', null)
        category.template = template.to_json()

      category.name = key
      category.content = json

      categories.push(category)

    return categories

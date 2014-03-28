W = require('when')
sort = require('./sort')
load = require('./load')

module.exports =
  class Category
    @all: (dir) ->
      deferred = W.defer()

      load.all_dynamic_content(dir).then (content) ->
        category_json = sort.by_category(content)
        deferred.resolve(category_json)

      return deferred.promise

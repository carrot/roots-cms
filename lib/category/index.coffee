W = require('when')
sort = require('./sort')
load = require('./load')

module.exports =
  class Category
    @all: (@cms, dir) ->
      deferred = W.defer()

      load.all_dynamic_content(@cms, dir).then (content) =>
        category_json = sort.by_category(@cms, content)
        deferred.resolve(category_json)

      return deferred.promise

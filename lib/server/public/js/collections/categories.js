(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'models/category'], function($, Category) {
    var Categories, _ref;
    return Categories = (function(_super) {
      __extends(Categories, _super);

      function Categories() {
        _ref = Categories.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Categories.prototype.model = Category;

      Categories.prototype.url = '/api/categories';

      Categories.prototype.comparator = function(m) {
        return m.get('name');
      };

      return Categories;

    })(Backbone.Collection);
  });

}).call(this);

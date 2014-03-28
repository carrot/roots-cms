(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'collections/content_collection', 'models/content', 'backbone_relational'], function(Backbone, ContentCollection, Content) {
    var Category, _ref;
    return Category = (function(_super) {
      __extends(Category, _super);

      function Category() {
        _ref = Category.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Category.prototype.relations = [
        {
          type: Backbone.HasMany,
          key: 'content',
          relatedModel: Content
        }
      ];

      return Category;

    })(Backbone.RelationalModel);
  });

}).call(this);

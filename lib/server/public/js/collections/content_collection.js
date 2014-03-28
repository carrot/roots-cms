(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'models/content', 'backbone_relational'], function($, Content) {
    var ContentCollection, _ref;
    return ContentCollection = (function(_super) {
      __extends(ContentCollection, _super);

      function ContentCollection() {
        _ref = ContentCollection.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ContentCollection.prototype.model = Content;

      ContentCollection.prototype.url = '/api/content';

      ContentCollection.prototype.comparator = function(m) {
        return m.get('order');
      };

      return ContentCollection;

    })(Backbone.RelationalModel);
  });

}).call(this);

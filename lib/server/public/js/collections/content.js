(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'models/content'], function($, Content) {
    var ContentCollection, _ref;
    return ContentCollection = (function(_super) {
      __extends(ContentCollection, _super);

      function ContentCollection() {
        _ref = ContentCollection.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ContentCollection.prototype.model = Content;

      ContentCollection.prototype.url = '/api';

      ContentCollection.prototype.initialize = function(models, opts) {
        return this.parent_dir = opts.parent_dir;
      };

      ContentCollection.prototype.comparator = function(m) {
        return m.get('order');
      };

      ContentCollection.prototype.save = function() {
        return $.ajax({
          url: this.url,
          type: "POST",
          data: {
            collection: this.models.map(function(m) {
              return m.toJSON();
            })
          },
          success: function(data) {
            return typeof console !== "undefined" && console !== null ? typeof console.log === "function" ? console.log(data) : void 0 : void 0;
          },
          error: function(data, message) {
            return typeof console !== "undefined" && console !== null ? typeof console.log === "function" ? console.log(data, message) : void 0 : void 0;
          }
        });
      };

      return ContentCollection;

    })(Backbone.Collection);
  });

}).call(this);

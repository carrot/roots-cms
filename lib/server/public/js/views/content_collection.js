(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['marionette', 'views/content', 'jquery', 'jqueryui'], function(Marionette, ContentView, $) {
    var ContentCollectionView, _ref;
    return ContentCollectionView = (function(_super) {
      __extends(ContentCollectionView, _super);

      function ContentCollectionView() {
        _ref = ContentCollectionView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ContentCollectionView.prototype.template = '#content-collection';

      ContentCollectionView.prototype.tagName = 'ul';

      ContentCollectionView.prototype.itemView = ContentView;

      ContentCollectionView.prototype.templateHelpers = function() {
        return {
          parent_dir: this.collection.parent_dir
        };
      };

      ContentCollectionView.prototype.onRender = function() {
        var _this = this;
        return this.$el.sortable({
          update: function() {
            return _this.resort();
          }
        });
      };

      ContentCollectionView.prototype.resort = function() {
        this.children.each(function(view) {
          return view.model.set('order', view.$el.index());
        });
        this.collection.sort().save();
        return this.render();
      };

      return ContentCollectionView;

    })(Marionette.CompositeView);
  });

}).call(this);

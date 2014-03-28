(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['marionette', 'views/category', 'jquery', 'jqueryui'], function(Marionette, CategoryView, $) {
    var ContentCollectionView, _ref;
    return ContentCollectionView = (function(_super) {
      __extends(ContentCollectionView, _super);

      function ContentCollectionView() {
        _ref = ContentCollectionView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ContentCollectionView.prototype.template = '#categories';

      ContentCollectionView.prototype.tagName = 'ul';

      ContentCollectionView.prototype.itemView = CategoryView;

      return ContentCollectionView;

    })(Marionette.CollectionView);
  });

}).call(this);

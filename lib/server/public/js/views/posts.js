(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['marionette', 'views/post', 'jquery', 'templates', 'jqueryui'], function(Marionette, PostView, $, templates) {
    var PostsView, _ref;
    return PostsView = (function(_super) {
      __extends(PostsView, _super);

      function PostsView() {
        _ref = PostsView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      PostsView.prototype.template = templates.posts;

      PostsView.prototype.itemViewContainer = 'ul';

      PostsView.prototype.itemView = PostView;

      return PostsView;

    })(Marionette.CompositeView);
  });

}).call(this);

(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['app', 'marionette', 'templates', 'jqueryui'], function(App, Marionette, templates) {
    var PostView, _ref;
    return PostView = (function(_super) {
      __extends(PostView, _super);

      function PostView() {
        _ref = PostView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      PostView.prototype.template = templates.post;

      PostView.prototype.tagName = 'li';

      PostView.prototype.events = {
        'click': 'path'
      };

      PostView.prototype.path = function() {
        var path;
        path = 'content/' + this.model.get('id');
        return App.request('router').navigate(path, {
          trigger: true
        });
      };

      return PostView;

    })(Marionette.ItemView);
  });

}).call(this);

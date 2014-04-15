(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['marionette', 'jqueryui'], function(Marionette) {
    var ContentView, _ref;
    return ContentView = (function(_super) {
      __extends(ContentView, _super);

      function ContentView() {
        _ref = ContentView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ContentView.prototype.template = '#content-item';

      ContentView.prototype.tagName = 'li';

      return ContentView;

    })(Marionette.ItemView);
  });

}).call(this);

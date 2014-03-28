(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'backbone_relational'], function(Backbone) {
    var Content, _ref;
    return Content = (function(_super) {
      __extends(Content, _super);

      function Content() {
        _ref = Content.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Content.prototype.urlRoot = '/api/content';

      return Content;

    })(Backbone.RelationalModel);
  });

}).call(this);

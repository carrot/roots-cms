(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['app', 'marionette', 'collections/categories', 'models/content', 'views/categories', 'views/content_edit', 'views/posts'], function(App, Marionette, Categories, Content, CategoriesView, ContentEditView, PostsView) {
    var Controller, _ref;
    return Controller = (function(_super) {
      __extends(Controller, _super);

      function Controller() {
        _ref = Controller.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Controller.prototype.list_categories = function() {
        return (new Categories).fetch({
          success: function(collection, res, opts) {
            return App.content.show(new CategoriesView({
              collection: collection
            }));
          },
          fail: function(collection, res, opts) {
            return typeof console !== "undefined" && console !== null ? typeof console.log === "function" ? console.log(collection, res, opts) : void 0 : void 0;
          }
        });
      };

      Controller.prototype.edit_content = function(path) {
        var model;
        if (model = Content.findOrCreate(path)) {
          return App.content.show(new ContentEditView({
            model: model
          }));
        }
        return (new Content({
          id: path
        })).fetch({
          success: function(model, res, opts) {
            return App.content.show(new ContentEditView({
              model: model
            }));
          },
          fail: function(model, res, opts) {
            return console.log(model, res, opts);
          }
        });
      };

      Controller.prototype.list_posts = function(folder) {
        return (new Categories).fetch({
          success: function(collection, res, opts) {
            var category, posts;
            category = collection.find(function(m) {
              return m.get('name') === folder;
            });
            posts = category.get('content');
            return App.content.show(new PostsView({
              collection: posts
            }));
          },
          fail: function(model, res, opts) {
            return console.log(model, res, opts);
          }
        });
      };

      return Controller;

    })(Marionette.Controller);
  });

}).call(this);

(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['app', 'marionette', 'templates', 'jqueryui', 'modal'], function(App, Marionette, templates) {
    var Category, _ref;
    return Category = (function(_super) {
      __extends(Category, _super);

      function Category() {
        _ref = Category.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Category.prototype.template = templates.category;

      Category.prototype.tagName = 'li';

      Category.prototype.ui = {
        'path': 'input',
        'modal': '.modal'
      };

      Category.prototype.events = {
        'click .category': 'path',
        'click .new': 'new_content',
        'click .create': 'create_content',
        'click .close': 'close_modal'
      };

      Category.prototype.path = function() {
        var path;
        path = 'category/' + this.model.get('name');
        return App.request('router').navigate(path, {
          trigger: true
        });
      };

      Category.prototype.new_content = function() {
        return this.ui.modal.trigger('openModal');
      };

      Category.prototype.create_content = function() {
        var path;
        path = "content/" + (this.model.get('name')) + "/" + (this.ui.path.val());
        if (path.split('.').reverse()[0] !== 'md') {
          path = path + '.md';
        }
        return App.request('router').navigate(path, {
          trigger: true
        });
      };

      Category.prototype.close_modal = function() {
        return this.ui.modal.trigger('closeModal');
      };

      Category.prototype.onRender = function() {
        return this.ui.modal.easyModal();
      };

      return Category;

    })(Marionette.ItemView);
  });

}).call(this);

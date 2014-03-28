(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['marionette', 'templates', 'underscore', 'marked', 'pen', 'html_md', 'pen_markdown'], function(Marionette, templates, _, marked, Pen, md) {
    var ContentShow, _ref;
    return ContentShow = (function(_super) {
      __extends(ContentShow, _super);

      function ContentShow() {
        _ref = ContentShow.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ContentShow.prototype.template = templates.content_show;

      ContentShow.prototype.ui = {
        'content': '.contents',
        'data': '.data input'
      };

      ContentShow.prototype.events = {
        'click button': 'save'
      };

      ContentShow.prototype.templateHelpers = function() {
        return {
          content_to_html: (function() {
            return marked(this.model.get('content'));
          }).bind(this)
        };
      };

      ContentShow.prototype.onRender = function() {
        return new Pen(this.ui.content[0]);
      };

      ContentShow.prototype.get_data = function() {
        return _.reduce(this.ui.data, function(data, el) {
          data[$(el).attr('name')] = $(el).val();
          return data;
        }, {});
      };

      ContentShow.prototype.save = function() {
        var modified_content;
        modified_content = md(this.ui.content.html());
        this.model.set('content', modified_content);
        this.model.set('data', this.get_data());
        return this.model.save();
      };

      return ContentShow;

    })(Marionette.ItemView);
  });

}).call(this);

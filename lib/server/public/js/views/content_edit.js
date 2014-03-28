(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['marionette', 'jquery', 'templates', 'underscore', 'marked', 'pen', 'html_md', 'dropzone', 'pen_markdown'], function(Marionette, $, templates, _, marked, Pen, md, Dropzone) {
    var ContentEdit, _ref;
    return ContentEdit = (function(_super) {
      __extends(ContentEdit, _super);

      function ContentEdit() {
        _ref = ContentEdit.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ContentEdit.prototype.template = templates.content_edit;

      ContentEdit.prototype.ui = {
        'content': '.contents',
        'data': '.data input',
        'back': '.back',
        'upload': '.upload',
        'upload_area': '.upload-area',
        'message': '.message',
        'modal': '.modal'
      };

      ContentEdit.prototype.events = {
        'click .save': 'save',
        'click .open-commit-modal': 'open_modal',
        'click .close': 'close_modal',
        'click .commit': 'commit',
        'click .back': 'go_back'
      };

      ContentEdit.prototype.templateHelpers = function() {
        return {
          content_to_html: (function() {
            return marked(this.model.get('content'));
          }).bind(this),
          category: (function() {
            return this.category_display();
          }).bind(this)
        };
      };

      ContentEdit.prototype.onRender = function() {
        this.ui.modal.easyModal();
        return new Pen({
          editor: this.ui.content[0],
          list: ['blockquote', 'h2', 'h3', 'p', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'bold', 'italic', 'underline', 'createlink', 'inserthtml'],
          debug: true,
          inserthtml: "<span class='upload-area' contenteditable='false'></span>",
          inserthtml_cb: function() {
            var drop, upload;
            upload = $('.upload-area')[0];
            $(upload).attr('contenteditable', false);
            drop = new Dropzone(upload, {
              url: '/api/upload_image'
            });
            return drop.on('success', function(file, res) {
              return $('.upload-area').replaceWith("<img src=\"" + res.url + "\"/>");
            });
          }
        });
      };

      ContentEdit.prototype.get_data = function() {
        return _.reduce(this.ui.data, function(data, el) {
          data[$(el).attr('name')] = $(el).val();
          return data;
        }, {});
      };

      ContentEdit.prototype.category_display = function() {
        var cats;
        cats = this.model.get('id').split('/');
        cats.pop();
        return cats.join('/');
      };

      ContentEdit.prototype.save = function() {
        var modified_content;
        modified_content = md(this.ui.content.html());
        this.model.set('content', modified_content);
        this.model.set('data', this.get_data());
        this.model.save();
        return this.render();
      };

      ContentEdit.prototype.commit = function() {
        var message;
        message = this.ui.message.val();
        this.save();
        return $.post('/api/commit', {
          id: this.model.id,
          message: message
        }).done(function(data) {
          return alert("successfully committed \"" + data + "\"");
        });
      };

      ContentEdit.prototype.open_modal = function() {
        return this.ui.modal.trigger('openModal');
      };

      ContentEdit.prototype.close_modal = function() {
        return this.ui.modal.trigger('closeModal');
      };

      return ContentEdit;

    })(Marionette.ItemView);
  });

}).call(this);

(function() {
  require.config({
    shim: {
      underscore: {
        exports: '_'
      },
      backbone: {
        deps: ['jquery', 'underscore'],
        exports: 'Backbone'
      },
      backbone_relational: {
        deps: ['backbone']
      },
      html_md: {
        exports: 'md'
      },
      pen: {
        deps: ['jquery'],
        exports: 'Pen'
      },
      pen_markdown: {
        deps: ['pen']
      },
      marionette: {
        deps: ['backbone'],
        exports: 'Marionette'
      },
      modal: {
        deps: ['jquery']
      }
    },
    paths: {
      app: 'application',
      backbone: 'vendor/backbone',
      backbone_relational: 'vendor/backbone-relational',
      dropzone: 'vendor/dropzone',
      html_md: 'vendor/md.min',
      jquery: 'vendor/jquery',
      jqueryui: 'vendor/jqueryui',
      marked: 'vendor/marked',
      marionette: 'vendor/backbone.marionette',
      modal: 'vendor/jquery_easy_modal',
      pen: 'vendor/pen/src/pen',
      pen_markdown: 'vendor/pen/src/markdown',
      underscore: 'vendor/underscore'
    }
  });

  require(['app', 'marionette', 'router', 'controller'], function(App, Marionette, Router, Controller) {
    App.on('initialize:after', function() {
      var router;
      router = new Router({
        controller: new Controller
      });
      App.reqres.setHandler('router', function() {
        return router;
      });
      return Backbone.history.start({
        pushState: true
      });
    });
    return App.start();
  });

}).call(this);

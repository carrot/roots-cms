(function() {
  define(['marionette'], function(Marionette) {
    var App;
    App = new Marionette.Application();
    App.addRegions({
      content: '#content'
    });
    return App;
  });

}).call(this);

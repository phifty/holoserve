
(function ($, namespace) {
  "use strict";

  var loaderNamespace = namespace.Loader || { };

  loaderNamespace.load = function (handler) {
    $.dojo.xhrGet({
      url: "/_control/layout.json",
      load: function (data) {
        handler($.dojo.fromJson(data));
      }
    });
  };

  namespace.Loader = loaderNamespace;

})(window, window.Transport = window.Transport || { });

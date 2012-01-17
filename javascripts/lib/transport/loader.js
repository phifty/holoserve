
(function ($, namespace) {
  "use strict";

  var loaderNamespace = namespace.Loader || { };

  loaderNamespace.load = function () {
    $.dojo.xhrGet({
      url: "/_control/layout.json",
      load: function (data) {
        $.Store.set($.dojo.fromJson(data));
      }
    });
  };

  namespace.Loader = loaderNamespace;

})(window, window.Transport = window.Transport || { });

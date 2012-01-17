
(function ($, namespace) {
  "use strict";

  namespace.run = function () {
    $.Interface.initialize();
    $.Transport.Loader.load(function (data) {
      $.Interface.load(data);
    });
  };

})(window, window.Application = window.Application || { });

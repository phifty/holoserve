
(function ($, namespace) {
  "use strict";

  namespace.run = function () {
    $.Transport.Loader.load();
    $.Interface.initialize();
  };

})(window, window.Application = window.Application || { });

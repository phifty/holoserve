
(function ($, namespace) {
  "use strict";

  namespace.run = function () {
    $.Transport.Loader.load();
  };

})(window, window.Application = window.Application || { });

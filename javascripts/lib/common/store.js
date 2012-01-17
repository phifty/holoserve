
(function ($, namespace) {
  "use strict";

  var _data = { };

  namespace.set = function (data) {
    _data = data;
  };

  namespace.get = function () {
    return _data;
  };

})(window, window.Store = window.Store || { });

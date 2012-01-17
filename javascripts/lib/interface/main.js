
(function ($, namespace) {
  "use strict";

  $.dojo.require("dojo.store.Memory");
  $.dojo.require("dojo.data.ObjectStore");

  $.dojo.require("dijit.layout.SplitContainer");
  $.dojo.require("dijit.layout.ContentPane");

  $.dojo.require("dojox.grid.DataGrid");

  var _requestsStore = undefined;

  namespace.initialize = function () {
    _requestsStore = new $.dojo.store.Memory({
      data: [ { method: "GET", path: "/" }, { method: "POST", path: "/oauth/tokens" } ]
    });

    $.dojo.ready(function () {
      var requestsGrid = $.dijit.byId("requestsGrid");
      requestsGrid.setStore($.dojo.data.ObjectStore({ objectStore: _requestsStore }));
    });
  };

})(window, window.Interface = window.Interface || { });

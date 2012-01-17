
(function ($, namespace) {
  "use strict";

  $.dojo.require("dojo.data.ObjectStore");

  $.dojo.require("dijit.layout.SplitContainer");
  $.dojo.require("dijit.layout.ContentPane");

  $.dojo.require("dojox.grid.DataGrid");

  var _requestsGrid = undefined;

  namespace.initialize = function () {
    $.dojo.ready(function () {
      _requestsGrid = $.dijit.byId("requestsGrid");
      $.dojo.connect(_requestsGrid, "onRowClick", _requestsGrid, function (event) {
        var index = event.rowIndex,
            row = this.getItem(index);

        console.log(row);
      });
    });
  };

  namespace.load = function (data) {
    _requestsGrid.setStore(
      $.dojo.data.ObjectStore({
        objectStore: new $.Interface.RequestsBridge({ data: data })
      }));
  }

})(window, window.Interface = window.Interface || { });

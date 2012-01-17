
(function ($, namespace) {
  "use strict";

  $.define("Interface.RequestsBridge", [
    "dojo/_base/declare",
    "dojo/_base/array",
    "dojo/store/util/QueryResults",
    "dojo/store/util/SimpleQueryEngine"
  ], function(declare, array, QueryResults, SimpleQueryEngine) {

    var _pairToRow = function (index, pair) {
          return {
            id: index,
            name: pair.name,
            method: pair.request.method,
            path: pair.request.path
          };
        },
        _rowToPair = function (row) {
          return {
            name: row.name,
            request: {
              method: row.method,
              path: row.path
            }
          };
        },
        _queryEngine = function (query, options) {
          return function (data) {
            return array.map(data, function (pair, index) {
              return _pairToRow(index, pair);
            });
          };
        };

    return declare("Interface.RequestsBridge", null, {

      constructor: function(options){
        for (var key in options) {
          this[key] = options[key];
        }
        this.setData(this.data || [ ]);
      },

      data: null,

      get: function (id) {
        return _pairToRow(id, this.data[id]);
      },

      getIdentity: function(pair) {
        return array.indexOf(this.data, pair);
      },

      put: function(row){
        var index = row && "id" in row ? row.id : this.data.length;

        this.data[index] = _rowToPair(row);

        return index;
      },

      add: function(object, options){
        return this.put(object, options);
      },

      remove: function(id){
        this.data.splice(id, 1);
      },

      query: function(query, options){
        return QueryResults(_queryEngine(query, options)(this.data));
      },

      setData: function (data) {
        this.data = data;
      }

    });
  });

})(window, window.Interface = window.Interface || { });

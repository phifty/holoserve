
module = (name) =>
  window[name] = window[name] or { }

module "Page"

Page.renderPairs = (pairs) =>
  html = "<h1>Pairs</h1>"
  html += "<table>"
  html += "<thead><th>ID</th><th>Method</th><th>Path</th></thead>"
  html += "<tbody>"
  html += "<tr><td>#{id}</td><td>#{pair.request.method}</td><td>#{pair.request.path}</td></tr>" for id, pair of pairs
  html += "</tbody>"
  html += "</table>"
  $("#content").html html

Page.showPairs = () =>
  $.ajax
    type: "GET"
    url: "/_control/pairs"
    dataType: "json"
    success: (response) =>
      Page.renderPairs response

Page.renderHistory = (history) =>
  html = "<h1>History</h1>"
  html += "<ol>"
  html += "<li>#{pairId}</li>" for pairId in history
  html += "</ol>"
  $("#content").html html

Page.showHistory = () =>
  $.ajax
    type: "GET"
    url: "/_control/history"
    dataType: "json"
    success: (response) =>
      Page.renderHistory response

Page.renderBucket = (bucket) =>
  html = "<h1>Bucket</h1>"
  html += "<ol>"
  html += "<li>#{pair.method} #{pair.path}</li>" for pair in bucket
  html += "</ol>"
  $("#content").html html

Page.showBucket = () =>
  $.ajax
    type: "GET"
    url: "/_control/bucket"
    dataType: "json"
    success: (response) =>
      Page.renderBucket response

module "Application"

Application.load = () =>
  $("#pairs").click () =>
    Page.showPairs()

  $("#history").click () =>
    Page.showHistory()

  $("#bucket").click () =>
    Page.showBucket()

  Page.showPairs()

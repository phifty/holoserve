
module = (name) =>
  window[name] = window[name] or { }

module "Template"

Template.setContent = (id, html) =>
  element = $ "#content"
  element.html html
  element.attr "class", id

Template.renderPair = (detailElement, pair) =>
  detailElement.html JSON.stringify(pair)

Template.renderPairs = (pairs) =>
  html = "<h1>Pairs</h1>\n"
  html += "<table>\n"
  html += "<thead><th>ID</th><th>Method</th><th>Path</th></thead>\n"
  html += "<tbody>\n"
  html += "<tr id=\"row_#{id}\"><td><a href=\"javascript:void(0)\">#{id}</a></td><td>#{pair.request.method}</td><td>#{pair.request.path}</td></tr>\n<tr><td colspan=\"3\" id=\"detail_#{id}\"></td></tr>" for id, pair of pairs
  html += "</tbody>\n"
  html += "</table>\n"
  Template.setContent "pairs", html
  $(".pairs td a").click (event) =>
    linkElement = $ event.target
    pairId = linkElement.text()
    Page.showPair pairId

Template.renderHistory = (history) =>
  html = "<h1>History</h1>\n"
  html += "<ol>\n"
  html += "<li>#{pairId}</li>\n" for pairId in history
  html += "</ol>\n"
  Template.setContent "history", html

Template.renderBucket = (bucket) =>
  html = "<h1>Bucket</h1>\n"
  html += "<ol>\n"
  html += "<li>#{pair.method} #{pair.path}</li>\n" for pair in bucket
  html += "</ol>\n"
  Template.setContent "bucket", html

module "Page"

Page.showPair = (id) =>
  detailElement = $ "#detail_#{id}"
  if detailElement.html() == ""
    $.ajax
      type: "GET"
      url: "/_control/pairs/#{id}"
      dataType: "json"
      success: (response) =>
        Template.renderPair detailElement, response
        detailElement.show()
  else
    detailElement.toggle()

Page.showPairs = () =>
  $.ajax
    type: "GET"
    url: "/_control/pairs"
    dataType: "json"
    success: (response) =>
      Template.renderPairs response

Page.showHistory = () =>
  $.ajax
    type: "GET"
    url: "/_control/history"
    dataType: "json"
    success: (response) =>
      Template.renderHistory response

Page.showBucket = () =>
  $.ajax
    type: "GET"
    url: "/_control/bucket"
    dataType: "json"
    success: (response) =>
      Template.renderBucket response

module "Effect"

Effect.flashPair = (id) =>
  rowElement = $ "#row_#{id}"
  rowElement = rowElement.animate { backgroundColor: "yellow" }, { duration: 200 }
  rowElement.animate { backgroundColor: "transparent" }, { duration: 2000 }

module "History"

History.add = (id) =>
  listElement = $ ".history ol"
  listElement.prepend "<li>#{id}</li>"

module "Event"

Event.connect = () =>
  webSocket = new WebSocket "ws://localhost:4250/_control/event"
  webSocket.onopen = () =>
    console.log "open"
  webSocket.onclose = () =>
    console.log "close"
  webSocket.onmessage = (event) =>
    pairId = event.data
    Effect.flashPair pairId
    History.add pairId

module "Application"

Application.load = () =>
  $("#pairs").click () =>
    Page.showPairs()
  $("#history").click () =>
    Page.showHistory()
  $("#bucket").click () =>
    Page.showBucket()
  Event.connect()
  Page.showPairs()

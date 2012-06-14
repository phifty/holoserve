
module = (name) =>
  window[name] = window[name] or { }

module "Formatter"

Formatter.prettyJson = (object, indent) =>
  result = ""
  indent = "" if indent == undefined

  for key, value of object
    if typeof value == "string"
      value = "'#{value}'"
    else if typeof value == "object"
      if value instanceof Array
        value = "[\n"
        value += Formatter.prettyJson item, indent + "  " for item in value
        value += "]";
      else
        od = Formatter.prettyJson value, indent + "  "
        value = "{\n#{od}\n#{indent}}"
    result += "#{indent}'#{key}': #{value},\n"

  return result.replace(/,\n$/, "")

module "Template"

Template.setContent = (id, html) =>
  element = $ "#content"
  element.html html
  element.attr "class", id

Template.renderPair = (id, pair) =>
  html = "<ul class=\"breadcrumb\">\n"
  html += "<li><a href=\"javascript:Page.showPairs();\">Pairs</a><span class=\"divider\">/</span></li>\n"
  html += "<li><a href=\"javascript:Page.showPair('#{id}');\">#{id}</a></li>\n"
  html += "</ul>\n"
  html += "<pre class=\"prettyprint linenums\">\n"
  html += Formatter.prettyJson pair, ""
  html += "</pre>\n"
  Template.setContent "pairs", html

Template.renderPairs = (pairs) =>
  html = "<ul class=\"breadcrumb\">\n"
  html += "<li><a href=\"javascript:Page.showPairs();\">Pairs</a></li>"
  html += "</ul>\n"
  html += "<table class='table table-striped'>\n"
  html += "<thead><th>ID</th><th>Method</th><th>Path</th></thead>\n"
  html += "<tbody>\n"
  for id, pair of pairs
    html += "<tr id=\"row_#{id}\">"
    html += "<td><a href=\"javascript:Page.showPair('#{id}');\">#{id}</a></td>"
    html += "<td>#{pair.requests.default.method}</td><td>#{pair.requests.default.path}</td>"
    html += "</tr>\n"
  html += "</tbody>\n"
  html += "</table>\n"
  Template.setContent "pairs", html

Template.renderHistory = (history) =>
  html = "<ul class=\"breadcrumb\">\n"
  html += "<li><a href=\"javascript:Page.showHistory();\">History</a></li>"
  html += "</ul>\n"
  html += "<ol>\n"
  html += "<li>#{Formatter.prettyJson pairId, ""}</li>\n" for pairId in history
  html += "</ol>\n"
  Template.setContent "history", html

Template.renderBucket = (bucket) =>
  html = "<ul class=\"breadcrumb\">\n"
  html += "<li><a href=\"javascript:Page.showBucket();\">Bucket</a></li>"
  html += "</ul>\n"
  html += "<ol>\n"
  for request in bucket
    html += "<pre class=\"prettyprint linenums\">\n"
    html += Formatter.prettyJson request, ""
    html += "</pre>\n"
  html += "</ol>\n"
  Template.setContent "bucket", html

module "Page"

Page.showPair = (id) =>
  $.ajax
    type: "GET"
    url: "/_control/pairs/#{id}"
    dataType: "json"
    success: (response) =>
      Template.renderPair id, response

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

module "Bucket"

Bucket.add = (request) =>
  preElements = $ ".bucket pre"
  preElements.before "<pre class=\"prettyprint linenums\">#{Formatter.prettyJson request, ""}</pre>"

module "Event"

Event.connect = () =>
  webSocket = new WebSocket "ws://localhost:4250/_control/event"
  webSocket.onopen = () =>
    console.log "open"
  webSocket.onclose = () =>
    console.log "close"
  webSocket.onmessage = (event) =>
    data = event.data.match /^(\w+):(.+)$/
    event = data[1]
    argument = data[2]
    Event["#{event}_event"] argument

Event.pair_event = (id) =>
  Effect.flashPair id
  History.add id

Event.bucket_event = (requestJson) =>
  request = JSON.parse requestJson
  Bucket.add request

module "Application"

Application.load = () =>
  $("#pairs").click () =>
    $("li.active").removeClass "active"
    Page.showPairs()
    $("a#pairs").parent().addClass "active"
  $("#history").click () =>
    $("li.active").removeClass "active"
    Page.showHistory()
    $("a#history").parent().addClass "active"
  $("#bucket").click () =>
    $("li.active").removeClass "active"
    Page.showBucket()
    $("a#bucket").parent().addClass "active"
  Event.connect()
  Page.showPairs()

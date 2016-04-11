json = { }
if window? then window.json = json # for the web
if module?.exports? then module.exports = json # for node

# json handling
json.load_json = (filename) ->
  $.ajaxSetup({ async: false})
  obj = null
  $.getJSON filename, (data) -> obj = data
  return obj
common = { }
if window? then window.common = common # for the web
if module?.exports? then module.exports = common # for node


# Checks for error, prints an error message (printf style), flushes the output (useful during debugging) and asserts
common.error_if_not = (check,msg...) -> if check then return else console.log(msg)

common.clone = (obj) ->
  if not obj? or typeof obj isnt 'object'
    return obj

  if obj instanceof Date
    return new Date(obj.getTime())

  if obj instanceof RegExp
    flags = ''
    flags += 'g' if obj.global?
    flags += 'i' if obj.ignoreCase?
    flags += 'm' if obj.multiline?
    flags += 'y' if obj.sticky?
    return new RegExp(obj.source, flags)

  newInstance = new obj.constructor()

  for key of obj
    newInstance[key] = common.clone obj[key]

  return newInstance
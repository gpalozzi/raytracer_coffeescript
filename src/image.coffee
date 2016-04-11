image = { }
if window? then window.image = image # for the web
if module?.exports? then module.exports = image # for node

vmath = window.vmath

# A generic image
class image.image3f
  @_w = 0
  @_h = 0
  @_d = null
  constructor: (@_w = 0, @_h = 0, v = null) ->
    @_d = (new vmath.vec3f v?.array() for i in [0...@_w*@_h])
  # image width
  wwidth: -> @_w
  # image height
  hheight: -> @_h
  # element access
  at: (i,j) -> return @_d[j*@_w+i]
  # element modifier
  set_at: (i,j,v) -> @_d[j*@_w+i] = v.clone()
  # data access
  data: -> @_d
  # flips this image along the y axis returning a new image
  flipy: ->
    ret = new image.image3f(@.wwidth(), @.hheight())
    for j in [0...@.hheight()]
      for i in [0...@.wwidth()]
        ret._d[(@.hheight()-1-j)*@.wwidth()+i] = (@.at(i,j)).clone()
    return ret
  # apply gamma correction
  gamma: (g) ->
    ret = new image.image3f({ w:@.wwidth(), h:@.hheight()})
    for j in [0...@.hheight()]
      for i in [0...@.wwidth()]
        ret._d[j*@_w+i] = (vmath.pow(@._d[j*@._w+i],g)).clone()
    return ret
  # apply a scale to the image
  scale: (s) ->
    ret = new image.image3f({ w:@.wwidth(), h:@.hheight()})
    for j in [0...@.hheight()]
      for i in [0...@.wwidth()]
        ret._d[j*@_w+i] = (vmath.mul(@._d[j*@._w+i],s)).clone()
    return ret
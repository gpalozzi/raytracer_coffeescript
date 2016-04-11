vmath = { }
if window? then window.vmath = vmath # for the web
if module?.exports? then module.exports = vmath # for node

common = window.common

# pi
vmath.PI = 3.1415926535897932384626433832795

# numeric conversion utilities --------------------------
vmath.int = (x) -> parseInt x

# math utilities --------------------------
# degrees to radians
vmath.radians = (deg) -> deg / 180 * PI
# radians to degrees
vmath.degrees = (rad) -> rad / PI * 180
# integer power of 2
vmath.pow2 = (x) ->
  ret = 1
  for i in [0...x]
    ret *=2
  return ret
# square
vmath.sqr = (x) -> x * x

# 2d vector
class vmath.vec2f
  constructor: (args = [0,0,0]) -> [@x,@y] = args
  clone: -> common.clone @
  # 2d component-wise arithmetic operators -----------
  #   -v
  opposite: -> new vmath.vec2f [-@x,-@y]
  #   v += b
  sum: (b) ->
    if b instanceof vmath.vec2f
      @x+=b.x
      @y+=b.y
      return @
  #   v -= b
  sub: (b) ->
    if b instanceof vmath.vec2f
      @x-=b.x
      @y-=b.y
      return @
  #   v *= b
  mul: (b) ->
    if b instanceof vmath.vec2f
      @x*=b.x
      @y*=b.y
      return @
    else if typeof b is "number"
      @x*=b
      @y*=b
      return @
  #   v /= b
  div: (b) ->
    if b instanceof vmath.vec2f
      @x/=b.x
      @y/=b.y
      return @
    else if typeof b is "number"
      @x/=b
      @y/=b
      return @

# 2d vector Constants -------------------------------
# zero
vmath.zero2f = new vmath.vec2f()
# one
vmath.one2f = new vmath.vec2f 1,1

# x, y
vmath.x2f = new vmath.vec2f 1,0
vmath.y2f = new vmath.vec2f 0,1

# 3d vector
class vmath.vec3f
  constructor: (args = [0,0,0]) -> [@x,@y,@z] = args
  clone: -> common.clone @
  # 3d component-wise arithmetic operators -----------
  #   -v
  opposite: -> return new vmath.vec3f [-@x,-@y,-@z]
  # return an array [@x,@y,@z]
  array : -> [@x,@y,@z]
  #   v += b
  sum: (b) ->
    if b instanceof vmath.vec3f
      @x+=b.x
      @y+=b.y
      @z+=b.z
      return @
  #   v -= b
  sub: (b) ->
    if b instanceof vmath.vec3f
      @x-=b.x
      @y-=b.y
      @z-=b.z
      return @
  #   v *= b
  mul: (b) ->
    if b instanceof vmath.vec3f
      @x*=b.x
      @y*=b.y
      @z*=b.z
      return @
    else if typeof b is "number"
      @x*=b
      @y*=b
      @z*=b
      return @
  #   v /= b
  div: (b) ->
    if b instanceof vmath.vec3f
      @x/=b.x
      @y/=b.y
      @z/=b.z
      return @
    else if typeof b is "number"
      @x/=b
      @y/=b
      @z/=b
      return @

# 3d vector Constants -------------------------------
# zero
vmath.zero3f = new vmath.vec3f
# one
vmath.one3f = new vmath.vec3f [1,1,1]

# x, y, z
vmath.x3f = new vmath.vec3f [1,0,0]
vmath.y3f = new vmath.vec3f [0,1,0]
vmath.z3f = new vmath.vec3f [0,0,1]

# 4d vector
class vmath.vec4f
  constructor: (args = [0,0,0,0]) -> [@x,@y,@z,@w] = args
  clone: -> common.clone @
  # 4d component-wise arithmetic operators -----------
  #   -v
  opposite: -> new vmath.vec4f [-@x,-@y,-@z,-@w]
  #   v += b
  sum: (b) ->
    if b instanceof vmath.vec4f
      @x+=b.x
      @y+=b.y
      @z+=b.z
      @w+=b.w
      return @
  #   v -= b
  sub: (b) ->
    if b instanceof vmath.vec4f
      @x-=b.x
      @y-=b.y
      @z-=b.z
      @w-=b.w
      return @
  #   v *= b
  mul: (b) ->
    if b instanceof vmath.vec4f
      @x*=b.x
      @y*=b.y
      @z*=b.z
      @w*=b.w
      return @
    else if typeof b is "number"
      @x*=b
      @y*=b
      @z*=b
      @w*=b
      return @
  #   v /= b
  div: (b) ->
    if b instanceof vmath.vec4f
      @x/=b.x
      @y/=b.y
      @z/=b.z
      @w/=b.w
      return @
    else if typeof b is "number"
      @x/=b
      @y/=b
      @z/=b
      @w/=b
      return @

# 4d vector Constants -------------------------------
# zero
vmath.zero4f = new vmath.vec4f
# one
vmath.one4f = new vmath.vec4f [1,1,1,1]
# x, y, z, w
vmath.x4f = new vmath.vec4f [1, 0, 0, 0]
vmath.y4f = new vmath.vec4f [0, 1, 0, 0]
vmath.z4f = new vmath.vec4f [0, 0, 1, 0]
vmath.w4f = new vmath.vec4f [0, 0, 0, 1]

# 2d integer vector
class vmath.vec2i
  constructor: (args = [0,0]) ->
    [@x,@y] = args
    @x = vmath.int @x
    @y = vmath.int @y
  clone: -> common.clone @
  # 2d integer component-wise arithmetic operators -----------
  #   -v
  opposite: -> new vmath.vec2i [-@x,-@y]
  #   v += b
  sum: (b) ->
    if b instanceof vmath.vec2i
      @x+=b.x
      @y+=b.y
      return @
  #   v -= b
  sub: (b) ->
    if b instanceof vmath.vec2i
      @x-=b.x
      @y-=b.y
      return @
  #   v *= b
  mul: (b) ->
    if b instanceof vmath.vec2i
      @x*=b.x
      @y*=b.y
      return @
    else if typeof b is "number"
      @x = vmath.int(@x*b)
      @y = vmath.int(@y*b)
      return @
  #   v /= b
  div: (b) ->
    if b instanceof vmath.vec2i
      @x = @x // b.x
      @y = @y // b.y
      return @
    else if typeof b is "number"
      @x = @x // b
      @y = @y // b
      return @

# 2d integer vector Constants -------------------------------
# zero
vmath.zero2i = new vmath.vec2i
# one
vmath.one2i = new vmath.vec2i [1,1]

# 3d integer vector
class vmath.vec3i
  constructor: (args = [0,0,0]) ->
    [@x,@y,@z] = args
    @x = vmath.int @x
    @y = vmath.int @y
    @z = vmath.int @z
  clone: -> common.clone @
  # 3d integer component-wise arithmetic operators -----------
  #   -v
  opposite: -> new vmath.vec3i [-@x,-@y,-@z]
  #   v += b
  sum: (b) ->
    if b instanceof vmath.vec3i
      @x+=b.x
      @y+=b.y
      @z+=b.z
      return @
  #   v -= b
  sub: (b) ->
    if b instanceof vmath.vec3i
      @x-=b.x
      @y-=b.y
      @z-=b.z
      return @
  #   v *= b
  mul: (b) ->
    if b instanceof vmath.vec3i
      @x*=b.x
      @y*=b.y
      @z*=b.z
      return @
    else if typeof b is "number"
      @x = vmath.int(@x*b)
      @y = vmath.int(@y*b)
      @z = vmath.int(@z*b)
      return @
  #   v /= b
  div: (b) ->
    if b instanceof vmath.vec3i
      @x = @x // b.x
      @y = @y // b.y
      @z = @z // b.z
      return @
    else if typeof b is "number"
      @x = @x // b
      @y = @y // b
      @z = @z // b
      return @

# 3d integer vector Constants -------------------------------
# zero
vmath.zero3i = new vmath.vec3i
# one
vmath.one3i = new vmath.vec3i [1,1,1]

# 4d integer vector
class vmath.vec4i
  constructor: (args = [0,0,0,0]) ->
    [@x,@y,@z,@w] = args
    @x = vmath.int @x
    @y = vmath.int @y
    @z = vmath.int @z
    @w = vmath.int @w
  clone: -> common.clone @
  # 4d integer component-wise arithmetic operators -----------
  #   -v
  opposite: -> new vmath.vec4i [-@x,-@y,-@z,-@w]
  #   v += b
  sum: (b) ->
    if b instanceof vmath.vec4i
      @x+=b.x
      @y+=b.y
      @z+=b.z
      @w+=b.w
      return @
  #   v -= b
  sub: (b) ->
    if b instanceof vmath.vec4i
      @x-=b.x
      @y-=b.y
      @z-=b.z
      @w-=b.w
      return @
  #   v *= b
  mul: (b) ->
    if b instanceof vmath.vec4i
      @x*=b.x
      @y*=b.y
      @z*=b.z
      @w*=b.w
      return @
    else if typeof b is "number"
      @x = vmath.int(@x*b)
      @y = vmath.int(@y*b)
      @z = vmath.int(@z*b)
      @w = vmath.int(@w*b)
      return @
  #   v /= b
  div: (b) ->
    if b instanceof vmath.vec4i
      @x = @x // b.x
      @y = @y // b.y
      @z = @z // b.z
      @w = @w // b.w
      return @
    else if typeof b is "number"
      @x = @x // b
      @y = @y // b
      @z = @z // b
      @w = @w // b
      return @

# 4d integer vector Constants -------------------------------
# zero
vmath.zero4i = new vmath.vec4i
# one
vmath.one4i = new vmath.vec4i [1,1,1,1]

# 3d coordinate frame
class vmath.frame3f
  constructor: (args = {}) ->
    @o = new vmath.vec3f args.o ? [0,0,0]
    @x = new vmath.vec3f args.x ? [1,0,0]
    @y = new vmath.vec3f args.y ? [0,1,0]
    @z = new vmath.vec3f args.z ? [0,0,1]
  clone: -> common.clone @

# frames constants ----------------------------------
# identity frame
vmath.identity_frame3f = new vmath.frame3f

# 4x4 Matrix
class vmath.mat4f
  constructor: (x_x = vmath.x4f, x_y = vmath.y4f, x_z = vmath.z4f, x_w = vmath.w4f, y_x,y_y,y_z,y_w, z_x,z_y,z_z,z_w, w_x,w_y,w_z,w_w) ->
    if arguments.length is 4 or arguments.length is 0
      @x = x_x.clone()
      @y = x_y.clone()
      @z = x_z.clone()
      @w = x_w.clone()
    else if arguments.length is 16
      @x = new vmath.vec4f(x_x, x_y, x_z, x_w)
      @y = new vmath.vec4f(y_x, y_y, y_z, y_w)
      @z = new vmath.vec4f(z_x, z_y, z_z, z_w)
      @w = new vmath.vec4f(w_x, w_y, w_z, w_w)
    else console.log "Error in function vmath.mat4f constructor"
  clone: -> common.clone @
  # 4d component-wise arithmetic operators -----------
  #   -v
  opposite: -> new vmath.mat4f(-@x,-@y,-@z,-@w)
  #   v += b
  sum: (b) ->
    if b instanceof vmath.mat4f
      @x.sum(b.x)
      @y.sum(b.y)
      @z.sum(b.z)
      @w.sum(b.w)
      return @
  #   v -= b
  sub: (b) ->
    if b instanceof vmath.mat4f
      @x.sub(b.x)
      @y.sub(b.y)
      @z.sub(b.z)
      @w.sub(b.w)
      return @
  #   v *= b
  mul: (b) ->
    if b instanceof vmath.mat4f
      temp = vmath.mul(this,b)
      @x = temp.x
      @y = temp.y
      @z = temp.z
      @w = temp.w
      return @
    else if typeof b is "number"
      @x.mul(b)
      @y.mul(b)
      @z.mul(b)
      @w.mul(b)
      return @
  #   v /= b
  div: (b) ->
    if typeof b is "number"
      @x.div(b)
      @y.div(b)
      @z.div(b)
      @w.div(b)
      return @

# 1D Bounding Interval
class vmath.range1f
  constructor: (@min = 1,@max = -1) ->

# 3D Bounding Interval
class vmath.range3f
  constructor: (@min = vmath.one3f.clone(),@max = vmath.one3f.opposite()) ->
    @min = @min.clone()
    @max = @max.clone()


# 2d, 3d, 4d & 2d, 3d, 4d integer & vmath.mat4f component-wise equality  -----------------------
vmath.equal = (a,b) ->
  # 2d
  if a instanceof vmath.vec2f and b instanceof vmath.vec2f then a.x==b.x and a.y==b.y
    # 3d
  else if a instanceof vmath.vec3f and b instanceof vmath.vec3f then a.x==b.x and a.y==b.y and a.z==b.z
    # 4d
  else if a instanceof vmath.vec4f and b instanceof vmath.vec4f then a.x==b.x and a.y==b.y and a.z==b.z and a.w==b.w
    # 2i
  else if a instanceof vmath.vec2i and b instanceof vmath.vec2i then a.x==b.x and a.y==b.y
    # 3i
  else if a instanceof vmath.vec3i and b instanceof vmath.vec3i then a.x==b.x and a.y==b.y and a.z==b.z
    # 4i
  else if a instanceof vmath.vec4i and b instanceof vmath.vec4i then a.x==b.x and a.y==b.y and a.z==b.z and a.w==b.w
    # vmath.frame3f
  else if a instanceof vmath.frame3f and b instanceof vmath.frame3f then vmath.equal(a.o,b.o) and vmath.equal(a.x,b.x) and vmath.equal(a.y,b.y) and vmath.equal(a.z,b.z)
    # vmath.mat4f
  else if a instanceof vmath.mat4f and b instanceof vmath.mat4f then vmath.equal(a.x,b.x) and vmath.equal(a.y,b.y) and vmath.equal(a.z,b.z) and vmath.equal(a.w,b.w)
    # 1d component-wise equality  -----------------------
  else if a instanceof vmath.range1f and b instanceof vmath.range1f then return a.min==b.min and a.max==b.max
    # 3d component-wise equality  -----------------------
  else if a instanceof vmath.range3f and b instanceof vmath.range3f then return vmath.equal(a.min,b.min) and vmath.equal(a.max,b.max)
    # error
  else console.log "Error in function vmath.equal"

# 2d, 3d, 4d & 2d, 3d, 4d integer & vmath.mat4f component-wise arithmetic operators -----------
vmath.sum = (a,b) ->
  # 2d
  if a instanceof vmath.vec2f and b instanceof vmath.vec2f then new vmath.vec2f [a.x+b.x, a.y+b.y]
    # 3d
  else if a instanceof vmath.vec3f and b instanceof vmath.vec3f then new vmath.vec3f [a.x+b.x, a.y+b.y, a.z+b.z]
    # 4d
  else if a instanceof vmath.vec4f and b instanceof vmath.vec4f then new vmath.vec4f [a.x+b.x, a.y+b.y, a.z+b.z, a.w+b.w]
    # 2i
  else if a instanceof vmath.vec2i and b instanceof vmath.vec2i then new vmath.vec2i [a.x+b.x, a.y+b.y]
    # 3i
  else if a instanceof vmath.vec3i and b instanceof vmath.vec3i then new vmath.vec3i [a.x+b.x, a.y+b.y, a.z+b.z]
    # 4i
  else if a instanceof vmath.vec4i and b instanceof vmath.vec4i then new vmath.vec4i [a.x+b.x, a.y+b.y, a.z+b.z, a.w+b.w]
    # vmath.mat4f
  else if a instanceof vmath.mat4f and b instanceof vmath.mat4f then new vmath.mat4f vmath.sum(a.x,b.x), vmath.sum(a.y,b.y), vmath.sum(a.z,b.z), vmath.sum(a.w,b.w)
    # error
  else console.log "Error in function sum"
vmath.sub = (a,b) ->
  # 2d
  if a instanceof vmath.vec2f and b instanceof vmath.vec2f then new vmath.vec2f [a.x-b.x, a.y-b.y]
    # 3d
  else if a instanceof vmath.vec3f and b instanceof vmath.vec3f then new vmath.vec3f [a.x-b.x, a.y-b.y, a.z-b.z]
    # 4d
  else if a instanceof vmath.vec4f and b instanceof vmath.vec4f then new vmath.vec4f [a.x-b.x, a.y-b.y, a.z-b.z, a.w-b.w]
    # 2i
  else if a instanceof vmath.vec2i and b instanceof vmath.vec2i then new vmath.vec2i [a.x-b.x, a.y-b.y]
    # 3i
  else if a instanceof vmath.vec3i and b instanceof vmath.vec3i then new vmath.vec3i [a.x-b.x, a.y-b.y, a.z-b.z]
    # 4i
  else if a instanceof vmath.vec4i and b instanceof vmath.vec4i then new vmath.vec4i [a.x-b.x, a.y-b.y, a.z-b.z, a.w-b.w]
    # vmath.mat4f
  else if a instanceof vmath.mat4f and b instanceof vmath.mat4f then new vmath.mat4f vmath.sub(a.x,b.x), vmath.sub(a.y,b.y), vmath.sub(a.z,b.z), vmath.sub(a.w,b.w)
    # error
  else console.log "Error in function sub"
vmath.mul = (a,b) ->
  # 2d * 2d
  if a instanceof vmath.vec2f and b instanceof vmath.vec2f then new vmath.vec2f [a.x*b.x, a.y*b.y] # vmath.vec2f multiplication
    # 2d * c
  else if a instanceof vmath.vec2f and typeof b is "number" then new vmath.vec2f [a.x*b, a.y*b] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec2f then new vmath.vec2f [b.x*a, b.y*a] # a is a constant
    # 3d * 3d
  else if a instanceof vmath.vec3f and b instanceof vmath.vec3f then new vmath.vec3f [a.x*b.x, a.y*b.y, a.z*b.z] # vmath.vec3f multiplication
    # 3d * c
  else if a instanceof vmath.vec3f and typeof b is "number" then new vmath.vec3f [a.x*b, a.y*b, a.z*b] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec3f then new vmath.vec3f [b.x*a, b.y*a, b.z*a] # a is a constant
    # 4d * 4d
  else if a instanceof vmath.vec4f and b instanceof vmath.vec4f then new vmath.vec4f [a.x*b.x, a.y*b.y, a.z*b.z, a.w*b.w] # vmath.vec4f multiplication
    # 4d * c
  else if a instanceof vmath.vec4f and typeof b is "number" then new vmath.vec4f [a.x*b, a.y*b, a.z*b, a.w*b] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec4f then new vmath.vec4f [b.x*a, b.y*a, b.z*a, b.w*a] # a is a constant
    # 2i * 2i
  else if a instanceof vmath.vec2i and b instanceof vmath.vec2i then new vmath.vec2i [a.x*b.x, a.y*b.y] # vmath.vec2i multiplication
    # 2i * c
  else if a instanceof vmath.vec2i and typeof b is "number" then new vmath.vec2i [vmath.int(a.x*b), vmath.int(a.y*b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec2i then new vmath.vec2i [vmath.int(b.x*a), vmath.int(b.y*a)] # a is a constant
    # 3i * 3i
  else if a instanceof vmath.vec3i and b instanceof vmath.vec3i then new vmath.vec3i [a.x*b.x, a.y*b.y, a.z*b.z] # vmath.vec3i multiplication
    # 3i * c
  else if a instanceof vmath.vec3i and typeof b is "number" then new vmath.vec3i [vmath.int(a.x*b), vmath.int(a.y*b), vmath.int(a.z*b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec3i then new vmath.vec3i [vmath.int(b.x*a), vmath.int(b.y*a), vmath.int(b.z*a)] # a is a constant
    # 4i * 4i
  else if a instanceof vmath.vec4i and b instanceof vmath.vec4i then new vmath.vec4i [a.x*b.x, a.y*b.y, a.z*b.z, a.w*b.w] # vmath.vec4i multiplication
    # 4i * c
  else if a instanceof vmath.vec4i and typeof b is "number" then new vmath.vec4i [vmath.int(a.x*b), vmath.int(a.y*b), vmath.int(a.z*b), vmath.int(a.w*b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec4i then new vmath.vec4i [vmath.int(b.x*a), vmath.int(b.y*a), vmath.int(b.z*a), vmath.int(b.w*a)] # a is a constant
    # vmath.mat4f * vmath.mat4f
  else if a instanceof vmath.mat4f and b instanceof vmath.mat4f
    new vmath.mat4f(a.x.x*b.x.x+a.x.y*b.y.x+a.x.z*b.z.x+a.x.w*b.w.x , a.x.x*b.x.y+a.x.y*b.y.y+a.x.z*b.z.y+a.x.w*b.w.y , a.x.x*b.x.z+a.x.y*b.y.z+a.x.z*b.z.z+a.x.w*b.w.z , a.x.x*b.x.w+a.x.y*b.y.w+a.x.z*b.z.w+a.x.w*b.w.w  , a.y.x*b.x.x+a.y.y*b.y.x+a.y.z*b.z.x+a.y.w*b.w.x , a.y.x*b.x.y+a.y.y*b.y.y+a.y.z*b.z.y+a.y.w*b.w.y , a.y.x*b.x.z+a.y.y*b.y.z+a.y.z*b.z.z+a.y.w*b.w.z , a.y.x*b.x.w+a.y.y*b.y.w+a.y.z*b.z.w+a.y.w*b.w.w  , a.z.x*b.x.x+a.z.y*b.y.x+a.z.z*b.z.x+a.z.w*b.w.x , a.z.x*b.x.y+a.z.y*b.y.y+a.z.z*b.z.y+a.z.w*b.w.y , a.z.x*b.x.z+a.z.y*b.y.z+a.z.z*b.z.z+a.z.w*b.w.z , a.z.x*b.x.w+a.z.y*b.y.w+a.z.z*b.z.w+a.z.w*b.w.w  , a.w.x*b.x.x+a.w.y*b.y.x+a.w.z*b.z.x+a.w.w*b.w.x , a.w.x*b.x.y+a.w.y*b.y.y+a.w.z*b.z.y+a.w.w*b.w.y , a.w.x*b.x.z+a.w.y*b.y.z+a.w.z*b.z.z+a.w.w*b.w.z , a.w.x*b.x.w+a.w.y*b.y.w+a.w.z*b.z.w+a.w.w*b.w.w  ) # vmath.mat4f multiplication
    # vmath.mat4f * vmath.vec4f
  else if a instanceof vmath.mat4f and b instanceof vmath.vec4f
    new vmath.vec4f [vmath.dot(a.x,b),vmath.dot(a.y,b),vmath.dot(a.z,b),vmath.dot(a.w,b)] # b is a vector 4d
    # vmath.mat4f * c
  else if a instanceof vmath.mat4f and typeof b is "number" then new vmath.mat4f vmath.mul(a.x,b), vmath.mul(a.y,b), vmath.mul(a.z,b), vmath.mul(a.w,b) # b is a constant
  else if typeof a is "number" and b instanceof vmath.mat4f then new vmath.mat4f vmath.mul(b.x,a), vmath.mul(b.y,a), vmath.mul(b.z,a), vmath.mul(b.w,a) # a is a constant
    # error
  else console.log "Error in function mul"
vmath.div = (a,b) ->
  # 2d / 2d
  if a instanceof vmath.vec2f and b instanceof vmath.vec2f then new vmath.vec2f [a.x/b.x, a.y/b.y] # vmath.vec2f division
    # 2d / c
  else if a instanceof vmath.vec2f and typeof b is "number" then new vmath.vec2f [a.x/b, a.y/b] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec2f then new vmath.vec2f [b.x/a, b.y/a] # a is a constant
    # 3d / 3d
  else if a instanceof vmath.vec3f and b instanceof vmath.vec3f then new vmath.vec3f [a.x/b.x, a.y/b.y, a.z/b.z] # vmath.vec3f division
    # 3d / c
  else if a instanceof vmath.vec3f and typeof b is "number" then new vmath.vec3f [a.x/b, a.y/b, a.z/b] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec3f then new vmath.vec3f [b.x/a, b.y/a, b.z/a] # a is a constant
    # 4d / 4d
  else if a instanceof vmath.vec4f and b instanceof vmath.vec4f then new vmath.vec4f [a.x/b.x, a.y/b.y, a.z/b.z, a.w/b.w] # vmath.vec4f division
    # 4d / c
  else if a instanceof vmath.vec4f and typeof b is "number" then new vmath.vec4f [a.x/b, a.y/b, a.z/b, a.w/b] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec4f then new vmath.vec4f [b.x/a, b.y/a, b.z/a, b.w/a] # a is a constant
    # 2i / 2i
  else if a instanceof vmath.vec2i and b instanceof vmath.vec2i then new vmath.vec2i [a.x//b.x, a.y//b.y] # vmath.vec2i division
    # 2i / c
  else if a instanceof vmath.vec2i and typeof b is "number" then new vmath.vec2i [a.x//b, a.y//b] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec2i then new vmath.vec2i [b.x//a, b.y//a] # a is a constant
    # 3i / 3i
  else if a instanceof vmath.vec3i and b instanceof vmath.vec3i then new vmath.vec3i [a.x//b.x, a.y//b.y, a.z//b.z] # vmath.vec3i division
    # 3i / c
  else if a instanceof vmath.vec3i and typeof b is "number" then new vmath.vec3i [a.x//b, a.y//b, a.z//b] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec3i then new vmath.vec3i [b.x//a, b.y//a, b.z//a] # a is a constant
    # 4i / 4i
  else if a instanceof vmath.vec4i and b instanceof vmath.vec4i then new vmath.vec4i [a.x//b.x, a.y//b.y, a.z//b.z, a.w//b.w] # vmath.vec4i division
    # 4i / c
  else if a instanceof vmath.vec4i and typeof b is "number" then new vmath.vec4i [a.x//b, a.y//b, a.z//b, a.w//b] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec4i then new vmath.vec4i [b.x//a, b.y//a, b.z//a, b.w//a] # a is a constant
    # vmath.mat4f * c
  else if a instanceof vmath.mat4f and typeof b is "number" then new vmath.mat4f vmath.div(a.x,b), vmath.div(a.y,b), vmath.div(a.z,b), vmath.div(a.w,b) # b is a constant
  else if typeof a is "number" and b instanceof vmath.mat4f then new vmath.mat4f vmath.div(b.x,a), vmath.div(b.y,a), vmath.div(b.z,a), vmath.div(b.w,a) # a is a constant
    # error
  else console.log "Error in function div"

# 2d & 3d component-wise functions ----------------------
# max, min, clamp
vmath.max = (a,b) ->
  # math utilities
  if typeof a is "number" and typeof b is "number"
    if a > b then return a else return b
    # 2d
  else if a instanceof vmath.vec2f and b instanceof vmath.vec2f then new vmath.vec2f [vmath.max(a.x,b.x), vmath.max(a.y,b.y)]
  else if a instanceof vmath.vec2f and typeof b is "number" then new vmath.vec2f [vmath.max(a.x,b), vmath.max(a.y,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec2f then new vmath.vec2f [vmath.max(a,b.x), vmath.max(a,b.x)] # a is a constant
    # 3d
  else if a instanceof vmath.vec3f and b instanceof vmath.vec3f then new vmath.vec3f [vmath.max(a.x,b.x), vmath.max(a.y,b.y), vmath.max(a.z,b.z)]
  else if a instanceof vmath.vec3f and typeof b is "number" then new vmath.vec3f [vmath.max(a.x,b), vmath.max(a.y,b), vmath.max(a.z,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec3f then new vmath.vec3f [vmath.max(a,b.x), vmath.max(a,b.x), vmath.max(a,b.z)] # a is a constant
    # 4d
  else if a instanceof vmath.vec4f and b instanceof vmath.vec4f then new vmath.vec4f [vmath.max(a.x,b.x), vmath.max(a.y,b.y), vmath.max(a.z,b.z), vmath.max(a.w,b.w)]
  else if a instanceof vmath.vec4f and typeof b is "number" then new vmath.vec4f [vmath.max(a.x,b), vmath.max(a.y,b), vmath.max(a.z,b), vmath.max(a.w,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec4f then new vmath.vec4f [vmath.max(a,b.x), vmath.max(a,b.x), vmath.max(a,b.z), vmath.max(a,b.w)] # a is a constant
    # 2i
  else if a instanceof vmath.vec2i and b instanceof vmath.vec2i then new vmath.vec2i [vmath.max(a.x,b.x), vmath.max(a.y,b.y)]
  else if a instanceof vmath.vec2i and typeof b is "number" then new vmath.vec2i [vmath.max(a.x,b), vmath.max(a.y,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec2i then new vmath.vec2i [vmath.max(a,b.x), vmath.max(a,b.x)] # a is a constant
    # 3i
  else if a instanceof vmath.vec3i and b instanceof vmath.vec3i then new vmath.vec3i [vmath.max(a.x,b.x), vmath.max(a.y,b.y), vmath.max(a.z,b.z)]
  else if a instanceof vmath.vec3i and typeof b is "number" then new vmath.vec3i [vmath.max(a.x,b), vmath.max(a.y,b), vmath.max(a.z,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec3i then new vmath.vec3i [vmath.max(a,b.x), vmath.max(a,b.x), vmath.max(a,b.z)] # a is a constant
    # 4i
  else if a instanceof vmath.vec4i and b instanceof vmath.vec4i then new vmath.vec4i [vmath.max(a.x,b.x), vmath.max(a.y,b.y), vmath.max(a.z,b.z), vmath.max(a.w,b.w)]
  else if a instanceof vmath.vec4i and typeof b is "number" then new vmath.vec4i [vmath.max(a.x,b), vmath.max(a.y,b), vmath.max(a.z,b), vmath.max(a.w,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec4i then new vmath.vec4i [vmath.max(a,b.x), vmath.max(a,b.x), vmath.max(a,b.z), vmath.max(a,b.w)] # a is a constant

vmath.min = (a,b) ->
  # math utilities
  if typeof a is "number" and typeof b is "number"
    if a < b then return a else return b
  # 2d
  if a instanceof vmath.vec2f and b instanceof vmath.vec2f then new vmath.vec2f [vmath.min(a.x,b.x), vmath.min(a.y,b.y)]
  else if a instanceof vmath.vec2f and typeof b is "number" then new vmath.vec2f [vmath.min(a.x,b), vmath.min(a.y,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec2f then new vmath.vec2f [vmath.min(a,b.x), vmath.min(a,b.x)] # a is a constant
    # 3d
  else if a instanceof vmath.vec3f and b instanceof vmath.vec3f then new vmath.vec3f [vmath.min(a.x,b.x), vmath.min(a.y,b.y), vmath.min(a.z,b.z)]
  else if a instanceof vmath.vec3f and typeof b is "number" then new vmath.vec3f [vmath.min(a.x,b), vmath.min(a.y,b), vmath.min(a.z,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec3f then new vmath.vec3f [vmath.min(a,b.x), vmath.min(a,b.x), vmath.min(a,b.z)] # a is a constant
    # 4d
  else if a instanceof vmath.vec4f and b instanceof vmath.vec4f then new vmath.vec4f [vmath.min(a.x,b.x), vmath.min(a.y,b.y), vmath.min(a.z,b.z), vmath.min(a.w,b.w)]
  else if a instanceof vmath.vec4f and typeof b is "number" then new vmath.vec4f [vmath.min(a.x,b), vmath.min(a.y,b), vmath.min(a.z,b), vmath.min(a.w,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec4f then new vmath.vec4f [vmath.min(a,b.x), vmath.min(a,b.x), vmath.min(a,b.z), vmath.min(a,b.w)] # a is a constant
    # 2i
  else if a instanceof vmath.vec2i and b instanceof vmath.vec2i then new vmath.vec2i [vmath.min(a.x,b.x), vmath.min(a.y,b.y)]
  else if a instanceof vmath.vec2i and typeof b is "number" then new vmath.vec2i [vmath.min(a.x,b), vmath.min(a.y,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec2i then new vmath.vec2i [vmath.min(a,b.x), vmath.min(a,b.x)] # a is a constant
    # 3i
  else if a instanceof vmath.vec3i and b instanceof vmath.vec3i then new vmath.vec3i [vmath.min(a.x,b.x), vmath.min(a.y,b.y), vmath.min(a.z,b.z)]
  else if a instanceof vmath.vec3i and typeof b is "number" then new vmath.vec3i [vmath.min(a.x,b), vmath.min(a.y,b), vmath.min(a.z,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec3i then new vmath.vec3i [vmath.min(a,b.x), vmath.min(a,b.x), vmath.min(a,b.z)] # a is a constant
    # 4i
  else if a instanceof vmath.vec4i and b instanceof vmath.vec4i then new vmath.vec4i [vmath.min(a.x,b.x), vmath.min(a.y,b.y), vmath.min(a.z,b.z), vmath.min(a.w,b.w)]
  else if a instanceof vmath.vec4i and typeof b is "number" then new vmath.vec4i [vmath.min(a.x,b), vmath.min(a.y,b), vmath.min(a.z,b), vmath.min(a.w,b)] # b is a constant
  else if typeof a is "number" and b instanceof vmath.vec4i then new vmath.vec4i [vmath.min(a,b.x), vmath.min(a,b.x), vmath.min(a,b.z), vmath.min(a,b.w)] # a is a constant
# clamp (sets x between m and M)
vmath.clamp = (x,m,M) ->
  # math utilities
  if typeof x is "number" and typeof m is "number" and typeof M is "number"
    return vmath.min(M,vmath.max(m,x))
  # 2d
  if x instanceof vmath.vec2f and m instanceof vmath.vec2f and M instanceof vmath.vec2f then new vmath.vec2f [vmath.clamp(x.x,m.x,M.x), vmath.clamp(x.y,m.y,M.y)]
  else if x instanceof vmath.vec2f and typeof m is "number" and typeof M is "number" then new vmath.vec2f [vmath.clamp(x.x,m,M), vmath.clamp(x.y,m,M)] # m and M are constants
    # 3d
  else if x instanceof vmath.vec3f and m instanceof vmath.vec3f and M instanceof vmath.vec3f then new vmath.vec3f [vmath.clamp(x.x,m.x,M.x), vmath.clamp(x.y,m.y,M.y), vmath.clamp(x.z,m.z,M.z)]
  else if x instanceof vmath.vec3f and typeof m is "number" and typeof M is "number" then new vmath.vec3f [vmath.clamp(x.x,m,M), vmath.clamp(x.y,m,M), vmath.clamp(x.z,m,M)] # m and M are constants
    # 4d
  else if x instanceof vmath.vec4f and m instanceof vmath.vec4f and M instanceof vmath.vec4f then new vmath.vec4f [vmath.clamp(x.x,m.x,M.x), vmath.clamp(x.y,m.y,M.y), vmath.clamp(x.z,m.z,M.z), vmath.clamp(x.w,m.w,M.w)]
  else if x instanceof vmath.vec4f and typeof m is "number" and typeof M is "number" then new vmath.vec4f [vmath.clamp(x.x,m,M), vmath.clamp(x.y,m,M), vmath.clamp(x.z,m,M), vmath.clamp(x.w,m,M)] # m and M are constants
    # 2i
  else if x instanceof vmath.vec2i and m instanceof vmath.vec2i and M instanceof vmath.vec2i then new vmath.vec2i [vmath.clamp(x.x,m.x,M.x), vmath.clamp(x.y,m.y,M.y)]
  else if x instanceof vmath.vec2i and typeof m is "number" and typeof M is "number" then new vmath.vec2i [vmath.clamp(x.x,m,M), vmath.clamp(x.y,m,M)] # m and M are constants
    # 3i
  else if x instanceof vmath.vec3i and m instanceof vmath.vec3i and M instanceof vmath.vec3i then new vmath.vec3i [vmath.clamp(x.x,m.x,M.x), vmath.clamp(x.y,m.y,M.y), vmath.clamp(x.z,m.z,M.z)]
  else if x instanceof vmath.vec3i and typeof m is "number" and typeof M is "number" then new vmath.vec3i [vmath.clamp(x.x,m,M), vmath.clamp(x.y,m,M), vmath.clamp(x.z,m,M)] # m and M are constants
    # 4i
  else if x instanceof vmath.vec4i and m instanceof vmath.vec4i and M instanceof vmath.vec4i then new vmath.vec4i [vmath.clamp(x.x,m.x,M.x), vmath.clamp(x.y,m.y,M.y), vmath.clamp(x.z,m.z,M.z), vmath.clamp(x.w,m.w,M.w)]
  else if x instanceof vmath.vec4i and typeof m is "number" and typeof M is "number" then new vmath.vec4i [vmath.clamp(x.x,m,M), vmath.clamp(x.y,m,M), vmath.clamp(x.z,m,M), vmath.clamp(x.w,m,M)] # m and M are constants

# elements array -------------------------
# from coordinates array to vec3f array
vmath.array_vec2f = (array) ->
  if array? and array.length %% 2 is 0 then (new vmath.vec2f [i...i+2] for i in array by 2)
  else []
vmath.array_vec2i = (array) ->
  if array? and array.length %% 2 is 0 then (new vmath.vec2i [i...i+2] for i in array by 2)
  else []
vmath.array_vec3f = (array) ->
  if array? and array.length %% 3 is 0 then (new vmath.vec3f [i...i+3] for i in array by 3)
  else []
vmath.array_vec3i = (array) ->
  if array? and array.length %% 3 is 0 then (new vmath.vec3i [i...i+3] for i in array by 3)
  else []
vmath.array_vec4i = (array) ->
  if array? and array.length %% 4 is 0 then (new vmath.vec4i [i...i+4] for i in array by 4)
  else []
vmath.array_vec4f = (array) ->
  if array? and array.length %% 4 is 0 then (new vmath.vec4f [i...i+4] for i in array by 4)
  else []
vmath.array_mat4f = (array) ->
  if array? and array.length %% 16 is 0 then (new vmath.mat4f(new vec4f[i...i+4],new vec4f[i+5...i+8],new vec4f[i+9...i+12],new vec4f[i+13...i+16])  for i in array by 16)
  else []

vmath.mean = (a) ->
  # 2d
  if a instanceof vmath.vec2f then return (a.x + a.y) / 2
    # 3d
  else if a instanceof vmath.vec3f then return (a.x + a.y + a.z) / 3
    # 4d
  else if a instanceof vmath.vec4f then return (a.x + a.y + a.z + a.w) / 4

# 2d, 3d & 4d vector operations -----------------------------
# dot product
vmath.dot = (a,b) ->
  # 2d
  if a instanceof vmath.vec2f and b instanceof vmath.vec2f then return a.x*b.x+a.y*b.y
    # 3d
  else if a instanceof vmath.vec3f and b instanceof vmath.vec3f then return a.x*b.x+a.y*b.y+a.z*b.z
    # 4d
  else if a instanceof vmath.vec4f and b instanceof vmath.vec4f then return a.x*b.x+a.y*b.y+a.z*b.z+a.w*b.w
# length and lengthSqr
vmath.llength = (a) -> if a instanceof vmath.vec2f or a instanceof vmath.vec3f or a instanceof vmath.vec4f then return Math.sqrt(vmath.dot(a,a))
vmath.lengthSqr = (a) -> if a instanceof vmath.vec2f or a instanceof vmath.vec3f or a instanceof vmath.vec4f then return vmath.dot(a,a)
# normalize
vmath.normalize = (a) ->
  # 2d
  if a instanceof vmath.vec2f
    l = vmath.llength(a)
    if l is 0 then return new vmath.vec2f else return vmath.mul(a, 1/l)
    # 3d
  else if a instanceof vmath.vec3f
    l = vmath.llength(a)
    if l is 0 then return new vmath.vec3f else return vmath.mul(a, 1/l)
    # 4d
  else if a instanceof vmath.vec4f
    l = vmath.llength(a)
    if l is 0 then return new vmath.vec4f else return vmath.mul(a, 1/l)
# 3d & 4d component-wise functions ----------------------
# pow, sqrt, exp
vmath.pow = (a,b) ->
  # 3d
  if a instanceof vmath.vec3f and typeof b is "number" then new vmath.vec3f [vmath.pow(a.x,b), vmath.pow(a.y,b), vmath.pow(a.z,b)]
    # 4d
  else if a instanceof vmath.vec4f and typeof b is "number" then new vmath.vec4f [vmath.pow(a.x,b), vmath.pow(a.y,b), vmath.pow(a.z,b), vmath.pow(a.w,b)]
vmath.sqrt = (a) ->
  # 3d
  if a instanceof vmath.vec3f then new vmath.vec3f [Math.sqrt(a.x), Math.sqrt(a.y), Math.sqrt(a.z)]
  else if a instanceof vmath.vec4f then new vmath.vec4f [Math.sqrt(a.x), Math.sqrt(a.y), Math.sqrt(a.z), Math.sqrt(a.w)]
vmath.exp = (a) ->
  if a instanceof vmath.vec3f then new vmath.vec3f [Math.exp(a.x), Math.exp(a.y), Math.exp(a.z)]
  else if a instanceof vmath.vec4f then new vmath.vec4f [Math.exp(a.x), Math.exp(a.y), Math.exp(a.z), Math.exp(a.w)]

# 3d vector operations -----------------------------
# distance and diatcne squared
vmath.dist = (a,b) -> if a instanceof vmath.vec3f and b instanceof vmath.vec3f then return vmath.llength(vmath.sub a,b)
vmath.distSqr = (a,b) -> if a instanceof vmath.vec3f and b instanceof vmath.vec3f then return vmath.lengthSqr(vmath.sub a,b)
# cross product
vmath.cross = (a,b) -> if a instanceof vmath.vec3f and b instanceof vmath.vec3f then return new vmath.vec3f [a.y*b.z-a.z*b.y, a.z*b.x-a.x*b.z, a.x*b.y-a.y*b.x]
# orthonormalization in the given order
vmath.orthonormalize_zyx = (x,y,z) ->
  if x instanceof vmath.vec3f and y instanceof vmath.vec3f and z instanceof vmath.vec3f
    z = vmath.normalize(z)
    x = vmath.normalize(vmath.cross y, z)
    y = vmath.normalize(vmath.cross z, x)
    # orthonormalize frame basis in the given order
  else if x instanceof vmath.frame3f
    ret = x.clone()
    vmath.orthonormalize_zyx(ret.x,ret.y,ret.z)
    return ret
vmath.orthonormalize_zxy = (x,y,z) ->
  if x instanceof vmath.vec3f and y instanceof vmath.vec3f and z instanceof vmath.vec3f
    z = vmath.normalize(z)
    y = vmath.normalize(vmath.cross z, x)
    x = vmath.normalize(vmath.cross y, z)
    # orthonormalize frame basis in the given order
  else if x instanceof vmath.frame3f
    ret = x.clone()
    vmath.orthonormalize_zxy(ret.x,ret.y,ret.z)
    return ret
vmath.orthonormalize_xzy = (x,y,z) ->
  if x instanceof vmath.vec3f and y instanceof vmath.vec3f and z instanceof vmath.vec3f
    x = vmath.normalize(x)
    y = vmath.normalize(vmath.cross z, x)
    z = vmath.normalize(vmath.cross x, y)
    # orthonormalize frame basis in the given order
  else if x instanceof vmath.frame3f
    ret = x.clone()
    vmath.orthonormalize_xzy(ret.x,ret.y,ret.z)
    return ret
# direction of mirror reflection of v with normal n (v is incoming)
vmath.reflect = (v,n) -> if v instanceof vmath.vec3f and n instanceof vmath.vec3f then vmath.sub(v, vmath.mul(n, 2 * vmath.dot(n,v)))
# direction of refraction of v with normal n (v is incoming --- from glsl documentation)
vmath.refract = (v, n, eta) ->
  if v instanceof vmath.vec3f and n instanceof vmath.vec3f and typeof eta is "number"
    k = 1 - eta * eta * (1 - vmath.dot(n,v)) * vmath.dot(n,v)
    return if k < 0 then new vmath.vec3f else vmath.sub( vmath.mul(eta,v) , vmath.mul(n , eta * vmath.dot(n,v) + Math.sqrt(k)) )

# 3d integer component-wise functions ----------------------
# max_component
vmath.max_component = (a) ->
  if a instanceof vmath.vec3i
    r = a.x
    r = vmath.max(r,a.x)
    r = vmath.max(r,a.y)
    r = vmath.max(r,a.z)
    return r
# min_component
vmath.min_component = (a) ->
  if a instanceof vmath.vec3i
    r = a.x
    r = vmath.min(r,a.x)
    r = vmath.min(r,a.y)
    r = vmath.min(r,a.z)
    return r

# frames & 4x4 matrix inverse -------------------------
vmath.inverse = (f) ->
  # inverse of a frame
  if f instanceof vmath.frame3f
    frame_obj = {
      o: [-vmath.dot(f.o,f.x), -vmath.dot(f.o,f.y), -vmath.dot(f.o,f.z)]
      x: [f.x.x, f.y.x, f.z.x]
      y: [f.x.y, f.y.y, f.z.y]
      z: [f.x.z, f.y.z, f.z.z]
    }
    new vmath.frame3f frame_obj
  else if f instanceof vmath.mat4f
    d = vmath.determinant(f)
    di = 1/d
    ret = new vmath.mat4f(+(+f.y.y*(f.z.z*f.w.w-f.z.w*f.w.z)-f.y.z*(f.z.y*f.w.w-f.z.w*f.w.y)+f.y.w*(f.z.y*f.w.z-f.z.z*f.w.y)), -(+f.x.y*(f.z.z*f.w.w-f.z.w*f.w.z)-f.x.z*(f.z.y*f.w.w-f.z.w*f.w.y)+f.x.w*(f.z.y*f.w.z-f.z.z*f.w.y)), +(+f.x.y*(f.y.z*f.w.w-f.y.w*f.w.z)-f.x.z*(f.y.y*f.w.w-f.y.w*f.w.y)+f.x.w*(f.y.y*f.w.z-f.y.z*f.w.y)), -(+f.x.y*(f.y.z*f.z.w-f.y.w*f.z.z)-f.x.z*(f.y.y*f.z.w-f.y.w*f.z.y)+f.x.w*(f.y.y*f.z.z-f.y.z*f.z.y)), -(+f.y.x*(f.z.z*f.w.w-f.z.w*f.w.z)-f.y.z*(f.z.x*f.w.w-f.z.w*f.w.x)+f.y.w*(f.z.x*f.w.z-f.z.z*f.w.x)), +(+f.x.x*(f.z.z*f.w.w-f.z.w*f.w.z)-f.x.z*(f.z.x*f.w.w-f.z.w*f.w.x)+f.x.w*(f.z.x*f.w.z-f.z.z*f.w.x)), -(+f.x.x*(f.y.z*f.w.w-f.y.w*f.w.z)-f.x.z*(f.y.x*f.w.w-f.y.w*f.w.x)+f.x.w*(f.y.x*f.w.z-f.y.z*f.w.x)), +(+f.x.x*(f.y.z*f.z.w-f.y.w*f.z.z)-f.x.z*(f.y.x*f.z.w-f.y.w*f.z.x)+f.x.w*(f.y.x*f.z.z-f.y.z*f.z.x)), +(+f.y.x*(f.z.y*f.w.w-f.z.w*f.w.y)-f.y.y*(f.z.x*f.w.w-f.z.w*f.w.x)+f.y.w*(f.z.x*f.w.y-f.z.y*f.w.x)), -(+f.x.x*(f.z.y*f.w.w-f.z.w*f.w.y)-f.x.y*(f.z.x*f.w.w-f.z.w*f.w.x)+f.x.w*(f.z.x*f.w.y-f.z.y*f.w.x)), +(+f.x.x*(f.y.y*f.w.w-f.y.w*f.w.y)-f.x.y*(f.y.x*f.w.w-f.y.w*f.w.x)+f.x.w*(f.y.x*f.w.y-f.y.y*f.w.x)), -(+f.x.x*(f.y.y*f.z.w-f.y.w*f.z.y)-f.x.y*(f.y.x*f.z.w-f.y.w*f.z.x)+f.x.w*(f.y.x*f.z.y-f.y.y*f.z.x)), -(+f.y.x*(f.z.y*f.w.z-f.z.z*f.w.y)-f.y.y*(f.z.x*f.w.z-f.z.z*f.w.x)+f.y.z*(f.z.x*f.w.y-f.z.y*f.w.x)), +(+f.x.x*(f.z.y*f.w.z-f.z.z*f.w.y)-f.x.y*(f.z.x*f.w.z-f.z.z*f.w.x)+f.x.z*(f.z.x*f.w.y-f.z.y*f.w.x)), -(+f.x.x*(f.y.y*f.w.z-f.y.z*f.w.y)-f.x.y*(f.y.x*f.w.z-f.y.z*f.w.x)+f.x.z*(f.y.x*f.w.y-f.y.y*f.w.x)), +(+f.x.x*(f.y.y*f.z.z-f.y.z*f.z.y)-f.x.y*(f.y.x*f.z.z-f.y.z*f.z.x)+f.x.z*(f.y.x*f.z.y-f.y.y*f.z.x)))
    return ret.mul(di)

# frames vector operations -------------------------
# creates a frame from z
vmath.frame_from_z = (z) ->
  if z instanceof vmath.vec3f
    f = vmath.identity_frame3f.clone()
    f.z = vmath.normalize(z)
    f.y = if Math.abs(vmath.dot(vmath.y3f,z)) > 0.95 then vmath.x3f.clone() else vmath.y3f.clone()
    return vmath.orthonormalize_zyx(f)

# frames creation ----------------------------------
# frame at eye that looks at center with vertical orientation as up (flipped changes z direction)
vmath.lookat_frame = (eye, center, up, flipped = false) ->
  if eye instanceof vmath.vec3f and center instanceof vmath.vec3f and up instanceof vmath.vec3f and typeof flipped is "boolean"
    f = new vmath.frame3f
    f.o = eye.clone()
    f.z = vmath.normalize(vmath.sub(center,eye))
    if flipped then f.z = f.z.opposite()
    f.y = up.clone()
    f = vmath.orthonormalize_zyx(f)
    return f

# frame-element transforms -------------------------
# matrix-element transforms ------------------------
# transform a point by a frame
vmath.transform_point = (f,v) ->
  if f instanceof vmath.frame3f and v instanceof vmath.vec3f
    ret = f.o.clone()
    ret.sum(vmath.mul(f.x,v.x))
    ret.sum(vmath.mul(f.y,v.y))
    ret.sum(vmath.mul(f.z,v.z))
    return ret
    # transform a point by a matrix
  else if f instanceof vmath.mat4f and v instanceof vmath.vec3f
    tv = vmath.mul(f,new vmath.vec4f [v.x,v.y,v.z,1])
    return vmath.div(new vmath.vec3f [tv.x,tv.y,tv.z], tv.w)
# transform a vector by a frame
vmath.transform_vector = (f,v) ->
  if f instanceof vmath.frame3f and v instanceof vmath.vec3f
    ret = vmath.mul(f.x,v.x)
    ret.sum(vmath.mul(f.y,v.y))
    ret.sum(vmath.mul(f.z,v.z))
    return ret
    # transform a vector by a matrix
  else if f instanceof vmath.mat4f and v instanceof vmath.vec3f
    tv = vmath.mul(f,new vmath.vec4f [v.x,v.y,v.z,0])
  return new vmath.vec3f [tv.x,tv.y,tv.z]
# transform a vector by a direciton
vmath.transform_direction = (f,v) ->
  if f instanceof vmath.frame3f and v instanceof vmath.vec3f
    return vmath.transform_vector(f,v)
    # transform a matrix by a direciton
  else if f instanceof vmath.mat4f and v instanceof vmath.vec3f
    return vmath.normalize(vmath.transform_vector(f,v))
# transform a normal by a frame
vmath.transform_normal = (f,v) ->
  if f instanceof vmath.frame3f and v instanceof vmath.vec3f
    return vmath.transform_vector(f,v)
    # transform a normal by a matrix
  else if f instanceof vmath.mat4f and v instanceof vmath.vec3f
    return vmath.normalize(vmath.transform_vector(f,v))
# transform a frame by a frame
vmath.transform_frame = (f,v) ->
  if f instanceof vmath.frame3f and v instanceof vmath.vec3f
    frame_obj = {
      o: vmath.transform_point(f,v.o).array()
      x: vmath.transform_vector(f,v.x).array()
      y: vmath.transform_vector(f,v.y).array()
      z: vmath.transform_vector(f,v.z).array()
    }
    new vmath.frame3f frame_obj
    # transform a frame by a matrix
  else if f instanceof vmath.mat4f and v instanceof vmath.vec3f
    ret = new vmath.frame3f
    ret.o = vmath.transform_point(f,v.o);
    ret.x = vmath.transform_direction(f,v.x)
    ret.y = vmath.transform_direction(f,v.y)
    ret.z = vmath.cross(ret.x,ret.y)
    ret = vmath.orthonormalize_zyx(ret)
    return ret
# frame-element inverse transforms ------------------
# transform a point by a frame inverse
vmath.transform_point_inverse = (f,v) -> if f instanceof vmath.frame3f and v instanceof vmath.vec3f
  new vmath.vec3f [vmath.dot(vmath.sub(v,f.o),f.x), vmath.dot(vmath.sub(v,f.o),f.y), vmath.dot(vmath.sub(v,f.o),f.z)]
# transform a vector by a frame inverse
vmath.transform_vector_inverse = (f,v) -> if f instanceof vmath.frame3f and v instanceof vmath.vec3f
  new vmath.vec3f [vmath.dot(v,f.x), vmath.dot(v,f.y), vmath.dot(v,f.z)]
# transform a direction by a frame inverse
vmath.transform_direction_inverse = (f,v) -> if f instanceof vmath.frame3f and v instanceof vmath.vec3f
  return vmath.transform_vector_inverse(f,v)
# transform a normal by a frame inverse
vmath.transform_normal_inverse = (f,v) -> if f instanceof vmath.frame3f and v instanceof vmath.vec3f
  return vmath.transform_vector_inverse(f,v)
# transform a frame by a frame inverse
vmath.transform_frame_inverse = (f,v) -> if f instanceof vmath.frame3f and v instanceof vmath.vec3f
  frame_obj = {
    o: vmath.transform_point_inverse(f,v.o).array()
    x: vmath.transform_vector_inverse(f,v.x).array()
    y: vmath.transform_vector_inverse(f,v.y).array()
    z: vmath.transform_vector_inverse(f,v.z).array()
  }
  return new vmath.frame3f frame_obj

# matrix constants ----------------------------------
# identity matrix
vmath.identity_mat4f = new vmath.mat4f

# 4x4 matrix operations ----------------------------
vmath.transpose = (a) -> if a instanceof vmath.mat4f
  new vmath.mat4f(a.x.x, a.y.x, a.z.x, a.w.x , a.x.y, a.y.y, a.z.y, a.w.y , a.x.z, a.y.z, a.z.z, a.w.z , a.x.w, a.y.w, a.z.w, a.w.w )
vmath.determinant = (a) -> if a instanceof vmath.mat4f
  return +a.x.x*(+a.y.y*(a.z.z*a.w.w-a.z.w*a.w.z)-a.y.z*(a.z.y*a.w.w-a.z.w*a.w.y)+a.y.w*(a.z.y*a.w.z-a.z.z*a.w.y))-a.x.y*(+a.y.x*(a.z.z*a.w.w-a.z.w*a.w.z)-a.y.z*(a.z.x*a.w.w-a.z.w*a.w.x)+a.y.w*(a.z.x*a.w.z-a.z.z*a.w.x))+a.x.z*(+a.y.x*(a.z.y*a.w.w-a.z.w*a.w.y)-a.y.y*(a.z.x*a.w.w-a.z.w*a.w.x)+a.y.w*(a.z.x*a.w.y-a.z.y*a.w.x))-a.x.w*(+a.y.x*(a.z.y*a.w.z-a.z.z*a.w.y)-a.y.y*(a.z.x*a.w.z-a.z.z*a.w.x)+a.y.z*(a.z.x*a.w.y-a.z.y*a.w.x))

# transform tests ----------------------------------
# tests whether a matrix is affine (approximately)
vmath.isaffine = (m) -> if m instanceof vmath.mat4f
  return m.w.x==0 and m.w.y==0 and m.w.z==0 and m.w.w==1

# transform matrices -------------------------------
# translation matrix
vmath.translation_matrix = (t) -> if t instanceof vmath.vec3f
  return new vmath.mat4f(1,0,0,t.x,  0,1,0,t.y,  0,0,1,t.z,  0,0,0,1)
# rotation matrix
vmath.rotation_matrix = (angle,axis) ->
  if typeof angle is "numeric" and axis instanceof vmath.vec3f
    c = Math.cos(angle)
    s = Math.sin(angle)
    vv = vmath.normalize(axis)
    return new vmath.mat4f(c + (1-c)*vv.x*vv.x, (1-c)*vv.x*vv.y - s*vv.z, (1-c)*vv.x*vv.z + s*vv.y, 0,  (1-c)*vv.x*vv.y + s*vv.z, c + (1-c)*vv.y*vv.y, (1-c)*vv.y*vv.z - s*vv.x, 0,  (1-c)*vv.x*vv.z - s*vv.y, (1-c)*vv.y*vv.z + s*vv.x, c + (1-c)*vv.z*vv.z, 0,  0,0,0,1)
# scaling matrix
vmath.scaling_matrix = (s) -> if s instanceof vmath.vec3f
  return new vmath.mat4f(s.x,0,0,0,  0,s.y,0,0,  0,0,s.z,0,  0,0,0,1)
# opengl frustum matrix
vmath.frustum_matrix = (l,r,b,t,n,f) -> if typeof l is "numeric" and typeof r is "numeric" and typeof b is "numeric" and typeof t is "numeric" and typeof n is "numeric" and typeof f is "numeric"
  return new vmath.mat4f(2*n/(r-l), 0, (r+l)/(r-l), 0,  0, 2*n/(t-b), (t+b)/(t-b), 0,  0, 0, -(f+n)/(f-n), -2*f*n/(f-n), 0, 0, -1, 0)
# opengl ortho matrix
vmath.ortho_matrix = (l,r,b,t,n,f) -> if typeof l is "numeric" and typeof r is "numeric" and typeof b is "numeric" and typeof t is "numeric" and typeof n is "numeric" and typeof f is "numeric"
  return new vmath.mat4f(2/(r-l), 0, 0, -(r+l)/(r-l),  0, 2/(t-b), 0, -(t+b)/(t-b),  0, 0, -2/(f-n), -(f+n)/(f-n), 0, 0, 0, 1)

# lookat matrix
vmath.lookat_matrix= (eye,center,up) ->
  if eye instanceof vmath.vec3f and center instanceof vmath.vec3f and up instanceof vmath.vec3f
    w = vmath.normalize(vmath.sub(eye, center))
    u = vmath.normalize(vmath.cross(up,w))
    v = vmath.cross(w,u)
    return new vmath.mat4f(u.x, u.y, u.z, -vmath.dot(u,eye),  v.x, v.y, v.z, -vmath.dot(v,eye),  w.x, w.y, w.z, -vmath.dot(w,eye),  0, 0, 0, 1)
# opengl glu ortho2d matrix
vmath.ortho2d_matrix = (l,r,b,t) -> if typeof l is "numeric" and typeof r is "numeric" and typeof b is "numeric" and typeof t is "numeric"
  return vmath.ortho_matrix(l,r,b,t,-1,1)
# opengl glu perspective matrix
vmath.perspective_matrix = (fovy,aspect,near,far) ->
  if typeof fovy is "numeric" and typeof aspect is "numeric" and typeof near is "numeric" and typeof far is "numeric"
    f = 1/tan(fovy/2)
    return new vmath.mat4f(f/aspect,0,0,0,   0,f,0,0,    0,0,(far+near)/(near-far),2*far*near/(near-far),    0,0,-1,0)

# frame-matrix conversion --------------------------
vmath.frame_to_matrix = (f) -> if f instanceof vmath.frame3f
  return new vmath.mat4f(f.x.x, f.y.x, f.z.x,f.o.x, f.x.y, f.y.y, f.z.y,f.o.y, f.x.z, f.y.z, f.z.z,f.o.z, 0,0,0,1)
vmath.frame_to_matrix_inverse = (f) -> if f instanceof vmath.frame3f
  return new vmath.mat4f(f.x.x, f.x.y, f.x.z, -vmath.dot(f.o,f.x), f.y.x, f.y.y, f.y.z, -vmath.dot(f.o,f.y), f.z.x, f.z.y, f.z.z, -vmath.dot(f.o,f.z), 0,0,0,1)
vmath.matrix_to_frame = (m) ->
  if m instanceof vmath.mat4f
    error_if_not(vmath.isaffine(m), "not affine")
    f = new vmath.frame3f()
    f.o = new vmath.vec3f [m.x.w, m.y.w, m.z.w]
    f.x = new vmath.vec3f [m.x.x, m.y.x, m.z.x]
    f.y = new vmath.vec3f [m.x.y, m.y.y, m.z.y]
    f.z = new vmath.vec3f [m.x.z, m.y.z, m.z.z]
    return f

# 1d bounding & 3d bounding interval operatons  -------------------
vmath.isvalid = (a) ->
  # 1d
  if a instanceof vmath.range1f then return vmath.min(a.min,a.max) == a.min
    # 3d
  else if a instanceof vmath.range3f then return vmath.equal(vmath.min(a.min,a.max),a.min)
vmath.size = (a) ->
  # 1d
  if a instanceof vmath.range1f then return a.max - a.min
    # 3d
  else if a instanceof vmath.range3f then return vmath.sub(a.max,a.min)
vmath.center = (a) ->
  # 1d
  if a instanceof vmath.range1f then return (a.max + a.min) / 2
    # 3d
  else if a instanceof vmath.range3f then return vmath.div(vmath.sum(a.max,a.min), 2)
vmath.runion = (a,b) ->
  # 1d
  if a instanceof vmath.range1f and typeof b is "number"
    if(not vmath.isvalid(a)) then return new vmath.range1f(b,b)
    return new vmath.range1f(vmath.min(a.min,b),vmath.max(a.max,b))
  else if a instanceof vmath.range1f and b instanceof vmath.range1f
    if(not vmath.isvalid(a)) then return b
    if(not vmath.isvalid(b)) then return a
    return new vmath.range1f(vmath.min(a.min,b.min),vmath.max(a.max,b.max))
    # 3d
  else if a instanceof vmath.range3f and typeof b is "number"
    if(not vmath.isvalid(a)) then return new vmath.range3f(b,b)
    return vmath.range3f(vmath.min(a.min,b),vmath.max(a.max,b))
  else if a instanceof vmath.range3f and b instanceof vmath.range3f
    if(not vmath.isvalid(a)) then return b
    if(not vmath.isvalid(b)) then return a
    return new vmath.range3f(vmath.min(a.min,b.min),vmath.max(a.max,b.max))
vmath.rscale = (a,b) ->
  # 1d
  if a instanceof vmath.range1f and typeof b is "number" then return new vmath.range1f(vmath.center(a)-vmath.size(a)*b/2,vmath.center(a)+vmath.size(a)*b/2)
    # 3d
  else if a instanceof vmath.range3f and typeof b is "number" then return new vmath.range3f(vmath.sub(vmath.center(a), vmath.mul(vmath.size(a), vmath.div(b,2))), vmath.sum(vmath.center(a), vmath.mul(vmath.size(a), vmath.div(b,2))))

# 3d bounding interval operatons  -------------------
vmath.make_range3f = (points) -> if points instanceof Array
  bbox = new vmath.range3f()
  bbox = vmath.runion(bbox,p) for p in points
  return bbox
vmath.corners = (a) -> if a instanceof vmath.range3f
  return [new vmath.vec3f [a.min.x,a.min.y,a.min.z], new vmath.vec3f [a.min.x,a.min.y,a.max.z], new vmath.vec3f [a.min.x,a.max.y,a.min.z], new vmath.vec3f [a.min.x,a.max.y,a.max.z], new vmath.vec3f [a.max.x,a.min.y,a.min.z], new vmath.vec3f [a.max.x,a.min.y,a.max.z], new vmath.vec3f [a.max.x,a.max.y,a.min.z], new vmath.vec3f [a.max.x,a.max.y,a.max.z]]

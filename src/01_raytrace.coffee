rtrace = { }
if window? then window.rtrace = rtrace # for the web
if module?.exports? then module.exports = rtrace # for node

scene = window.scene
image = window.image
vmath = window.vmath

# intersection record
class rtrace.intersection3f
  constructor: (@hit = false, @ray_t, @pos, @norm, @mat) ->
  # @hit = false        # whether it hits something
  # @ray_t              # ray parameter for the hit
  # @pos                # hit position
  # @norm               # hit normal
  # @mat                # hit material

rtrace.ray3f_epsilon = 0.0005
rtrace.ray3f_rayinf = 1000000

# 3D Ray
class rtrace.ray3f
  constructor: (@e = vmath.zero3f.clone(), @d = vmath.z3f.clone(), @tmin = rtrace.ray3f_epsilon, @tmax = rtrace.ray3f_rayinf) ->
  # Eval ray at a specific t
  eval: (t) -> vmath.sum(@e, vmath.mul(@d, t))

# Create a ray from a segment
rtrace.make_segment = (a,b) -> if a instanceof vmath.vec3f and b instanceof vmath.vec3f
  return new rtrace.ray3f a.clone(), vmath.normalize(vmath.sub(b,a)), rtrace.ray3f_epsilon, vmath.dist(a,b) - 2 * rtrace.ray3f_epsilon

# transform a ray by a frame
rtrace.transform_ray = (f,v) -> if f instanceof vmath.frame3f and v instanceof rtrace.ray3f
  return new rtrace.ray3f vmath.transform_point(f,v.e), vmath.transform_vector(f,v.d), v.tmin, v.tmax
# transform a ray by a frame inverse
rtrace.transform_ray_inverse = (f,v) -> if f instanceof vmath.frame3f and v instanceof rtrace.ray3f
  return new rtrace.ray3f vmath.transform_point_inverse(f,v.e), vmath.transform_vector_inverse(f,v.d), v.tmin, v.tmax

# intersects the scene and return the first intrerseciton
intersect = (s,ray) -> if s instanceof scene.Scene and ray instanceof rtrace.ray3f
  # create a default intersection record to be returned
  intersection = new rtrace.intersection3f
  # foreach surface
  for surface in s.surfaces
    # if it is a quad
    if surface.isquad
      # compute ray intersection (and ray parameter), continue if not hit
      tray = rtrace.transform_ray_inverse(surface.frame,ray)
      if tray.d.z is 0 then continue
      t = - tray.e.z / tray.d.z
      p = tray.eval(t)
      if surface.radius < p.x or -surface.radius > p.x or surface.radius < p.y or -surface.radius > p.y then continue

      # check if computed param is within ray.tmin and ray.tmax
      if t < tray.tmin or t > tray.tmax then continue

      # check if this is the closest intersection, continue if not
      if t > intersection.ray_t and intersection.hit  then continue

      # if hit, set intersection record values
      intersection.hit = true
      intersection.ray_t = t
      intersection.pos = vmath.transform_point surface.frame, p
      intersection.norm = vmath.transform_normal surface.frame, vmath.z3f
      intersection.mat = surface.mat.clone()
    else
      # compute ray intersection (and ray parameter), continue if not hit
      # just grab only the first hit
      tray = rtrace.transform_ray_inverse(surface.frame,ray)
      a = vmath.lengthSqr(tray.d)
      b = 2 * vmath.dot(tray.d,tray.e)
      c = vmath.lengthSqr(tray.e) - surface.radius * surface.radius
      d = b*b-4*a*c
      if(d < 0) then continue
      t = (-b - Math.sqrt(d)) / (2*a)

      # check if computed param is within ray.tmin and ray.tmax
      if not (t >= tray.tmin and t <= tray.tmax) then continue

      # check if this is the closest intersection, continue if not
      if t > intersection.ray_t and intersection.hit then continue

      # if hit, set intersection record values
      intersection.hit = true;
      intersection.ray_t = t;
      intersection.pos = vmath.transform_point surface.frame, tray.eval(t)
      intersection.norm = vmath.transform_normal surface.frame, vmath.normalize(tray.eval(t))
      intersection.mat = surface.mat.clone()
  # record closest intersection
  return intersection

# compute the color corresponing to a ray by raytracing
raytrace_ray = (s,ray) -> if s instanceof scene.Scene and ray instanceof rtrace.ray3f
  # get scene intersection
  intersection = intersect s, ray
  # if not hit, return background
  if not intersection.hit then return s.background

  # accumulate color starting with ambient
  c = vmath.mul s.ambient, intersection.mat.kd

  # foreach light
  for light in s.lights
    # compute light response
    cl = vmath.div light.intensity, vmath.lengthSqr(vmath.sub intersection.pos, light.frame.o)
    # compute light direction
    l = vmath.normalize(vmath.sub light.frame.o, intersection.pos)
    # compute the material response (brdf*cos)
    h = vmath.normalize(vmath.sum ray.d.opposite(), l)
    shade = vmath.mul cl , vmath.max(vmath.dot(intersection.norm,l),0)
    shade.mul vmath.sum intersection.mat.kd, vmath.mul(intersection.mat.ks,Math.pow(vmath.max(0,vmath.dot(intersection.norm,h)), intersection.mat.n))
    # check for shadows and accumulate if needed
    if(vmath.equal shade, vmath.zero3f) then continue
    if(not intersect(s,rtrace.make_segment(intersection.pos,light.frame.o)).hit)
        c.sum shade

  # if the material has reflections
  if not (vmath.equal intersection.mat.kr , vmath.zero3f)
    # create the reflection ray
    rr = new rtrace.ray3f intersection.pos.clone(), vmath.sub(ray.d, vmath.mul(2*vmath.dot(ray.d,intersection.norm), intersection.norm))
    # accumulate the reflected light (recursive call) scaled by the material reflection
    c.sum vmath.mul(intersection.mat.kr, raytrace_ray(s,rr))

  # return the accumulated color
  return c

# raytrace an image
raytrace = (s) -> if s instanceof scene.Scene
  # allocate an image of the proper size
  img = new image.image3f s.image_width, s.image_height
  # if no anti-aliasing
  if s.image_samples <= 1
    # foreach pixel
    for j in [0...s.image_height]
      for i in [0...s.image_width]
        # compute ray-camera parameters (u,v) for the pixel
        u = (i + 0.5) / s.image_width
        v = (j + 0.5) / s.image_height
        # compute camera ray
        ray = rtrace.transform_ray s.camera.frame, new rtrace.ray3f(vmath.zero3f.clone(), vmath.normalize(new vmath.vec3f [(u-0.5)*s.camera.width,(v-0.5)*s.camera.height,-1]))
        # set pixel to the color raytraced with the ray
        color = raytrace_ray(s,ray)
        img.set_at(i,j,color)
  else
    # foreach pixel
    for j in [0...s.image_height]
      for i in [0...s.image_width]
        # init accumulated color
        for jj in [0...s.image_samples]
          for ii in [0...s.image_samples]
            # compute ray-camera parameters (u,v) for the pixel and the sample
            u = (i + (ii + 0.5)/s.image_samples) / s.image_width
            v = (j + (jj + 0.5)/s.image_samples) / s.image_height
            # compute camera ray
            ray = rtrace.transform_ray s.camera.frame, new rtrace.ray3f(vmath.zero3f.clone(), vmath.normalize( new vmath.vec3f [(u-0.5)*s.camera.width,(v-0.5)*s.camera.height,-1]))
            # set pixel to the color raytraced with the ray
            p = img.at(i,j)
            p.sum raytrace_ray(s,ray)
            img.set_at(i,j,p)
        # scale by the number of samples
        p = img.at(i,j)
        p.div (s.image_samples*s.image_samples)

  #done
  return img

exec = (img) ->
  canv = document.getElementById "display"
  canv.width = img.wwidth()
  canv.height = img.hheight()
  # document.body.appendChild canv
  ctx = canv.getContext "2d"
  ctx.clearRect 0, 0, canv.width, canv.height
  for y in [0...canv.height]
    for x in [0...canv.width]
      vec = img.at(x,canv.height-1-y)
      pixel = [vmath.clamp(vec.x  * 255, 0, 255),vmath.clamp(vec.y * 255, 0, 255),vmath.clamp(vec.z * 255, 0, 255)]
      ctx.fillStyle = "rgb(#{Math.floor pixel[0]},#{Math.floor pixel[1]},#{Math.floor pixel[2]})"
      #( ( flipY ? (img.height()-1-y) : y ) * img.width() + x ) * 4
      ctx.fillRect x, y, x + 1, y + 1

rtrace.raytrace_01 = (scene_filename) ->
  s = scene.load_json_scene(scene_filename)
  img = raytrace(s)
  # console.log pixel, _i for pixel in img.data() when not vmath.equal pixel, s.background
  exec(img)
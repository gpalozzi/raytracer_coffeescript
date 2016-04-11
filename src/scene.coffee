scene = { }
if window? then window.scene = scene # for the web
if module?.exports? then module.exports = scene # for node

vmath = window.vmath
json = window.json
common = window.common

# blinn-phong material
# textures are scaled by the respective coefficient and may be missing
class scene.Material
  constructor: (args = {}) ->
    @ke = new vmath.vec3f args.ke ? vmath.zero3f.array()            # emission coefficient
    @kd = new vmath.vec3f args.kd ? vmath.one3f.array()             # diffuse coefficient
    @ks = new vmath.vec3f args.ks ? vmath.zero3f.array()            # specular coefficient
    @n = args.n ? 10                                          # specular exponent
    @kr = new vmath.vec3f args.kr ? vmath.zero3f.array()            # reflection coefficient

    @ke_txt = args.ke_txt ? null                    # emission texture
    @kd_txt = args.kd_txt ? null                    # diffuse texture
    @ks_txt = args.ks_txt ? null                    # specular texture
    @kr_txt = args.kr_txt ? null                    # reflection texture
    @norm_txt = args.norm_txt ? null                # normal texture

    @double_sided = args.double_sided ? false       # double-sided material
    @microfacet = args.microfacet ? false           # use microfacet formulation
  clone: -> common.clone @

# Keyframed Animation Data
class scene.FrameAnimation
  constructor: (args = {}) ->
    @rest_frame = if args.rest_frame? then new vmath.frame3f args.rest_frame else vmath.identity_frame3f.clone()  # animation rest frame
    @keytimes = args.keytimes ? []  # key frame times
    @translation = vmath.array_vec3f args.translation # translation key frames
    @rotation = vmath.array_vec3f args.rotation  # rotation key frames

# Mesh Skinning Data
class scene.MeshSkinning
  constructor: (args = {}) ->
    @rest_pos = vmath.array_vec3f args.rest_pos      # rest pos
    @rest_norm = vmath.array_vec3f args.rest_norm     # rest norm
    @bone_ids = vmath.array_vec4i args.bone_ids      # skin bones
    @bone_weights = vmath.array_vec4f args.bone_weights  # skin weights
    @bone_xforms = if args.bone_xforms? then (vmath.array_mat4f array for array in args.bone_xforms) else []   # bone xforms (bone index is the first index)

# Mesh Simulation Data
class scene.MeshSimulation
  constructor: (args = {}) ->
    # simulation init data
    @init_pos = vmath.array_vec3f args.init_pos  # initial position
    @init_vel = vmath.array_vec3f args.init_vel  # initial velocity
    @mass = args.mass ? []      # mass
    @pinned = args.pinned ? []    # whether a point is pinned

    # inter-particle springs
    @springs = scene.array_spring args.springs    # springs

    # simulation compute data
    @vel = vmath.array_vec3f args.vel       # velocity
    @force = vmath.array_vec3f args.force     # forces

# inter-particle springs
class scene.Spring
  constructor: (args = {}) ->
    @ids = new vmath.vec2i args.ids       # springs vertex ids
    @restlength = args.restlength ? null        # springs rest length
    @ks = args.ks ? null                         # springs static constant
    @kd = args.kd ? null                         # springs dynamic constant

# array of springs
scene.array_spring = (list) ->
  if list? then (new scene.Spring spring for spring in list)

# Mesh Collision Data
class scene.MeshCollision
  constructor: (args = {}) ->
    @radius = args.radius ? null    # collision radius
    @isquad = args.isquad ? null    # whether the collision object is a sphere or quad

# indexed mesh data structure with vertex positions and normals,
# a list of indices for triangle and quad faces, material and frame
class scene.Mesh
  constructor: (args = {}) ->
    @frame = if args.frame? then new vmath.frame3f args.frame else vmath.identity_frame3f.clone() # frame
    @pos = vmath.array_vec3f args.pos                        # vertex position
    @norm = vmath.array_vec3f args.norm                      # vertex normal
    @texcoord = vmath.array_vec2f args.texcoord              # vertex texcture coordinates
    @triangle = vmath.array_vec3i args.triangle              # triangle
    @quad = vmath.array_vec4i args.quad                      # quad
    @point = args.point ? []                                 # point
    @line = vmath.array_vec2i args.line                      # line
    @spline = vmath.array_vec4i args.spline                  # cubic bezier segments
    @mat = new scene.Material args.material                # material

    @subdivision_catmullclark_level = args.subdivision_catmullclark_level ? 0        # catmullclark subdiv level
    @subdivision_catmullclark_smooth = args.subdivision_catmullclark_smooth ? false  # catmullclark subdiv smooth
    @subdivision_bezier_level = args.subdivision_bezier_level ? 0                    # bezier subdiv level

    @animation = if args.animation? then new scene.FrameAnimation args.animation else null     # animation data
    @skinning = if args.skinning? then new scene.MeshSkinning args.skinning else null        # skinning data
    console.log "json_skinning not implemented"
    @simulation = if args.simulation? then new scene.MeshSimulation args.simulation else null   # simulation data
    @collision = null                                         # collision data

    @bvh = null;                                               # bvh accelerator for intersection

# surface made of eitehr a spehre or a quad (as determined by
# isquad. the sphere is centered frame.o with radius radius.
# the quad is at frame.o with normal frame.z and axes frame.x, frame.y.
# the quad side is 2*radius.
class scene.Surface
  constructor: (args = {}) ->
    @frame = if args.frame? then new vmath.frame3f args.frame else vmath.identity_frame3f.clone() # frame
    @radius = args.radius ? 1                     # radius
    @isquad = args.isquad ? false                 # whether it's a quad
    @mat = new scene.Material args.material           # material

    @animation = if args.animation then new scene.FrameAnimation args.animation else null            # animation data

    @display_mesh = args.display_mesh ? null      # display mesh

# point light at frame.o with intensity intensity
class scene.Light
  constructor: (args = {}) ->
    @frame = if args.frame? then new vmath.frame3f args.frame else vmath.identity_frame3f.clone()       # frame
    @intensity = if args.intensity? then new vmath.vec3f args.intensity else vmath.one3f.clone()        # intersntiy

# perspective camera at frame.o with direction (-z)
# and image plane orientation (x,y); the image plane
# is at a distance dist with size (width,height);
# the camera is focussed at a distance focus.
class scene.Camera
  constructor: (args = {}) ->
    @frame = if args.frame? then new vmath.frame3f args.frame else vmath.identity_frame3f.clone()
    @width = args.width ? 1
    @height = args.height ? 1
    @dist = args.dist ? 1
    @focus = args.focus ? 1

# Scene Animation Data
class scene.SceneAnimation
  constructor: (args = {}) ->
    @time = args.time ? 0                                         # current animation time
    @length = args.length ? 0                                     # animation length
    @dest = args.dt ? 1/30                                      # time in seconds for each time step
    @simsteps = args.simsteps ? 100                               # simulation steps for time step of animation
    @gravity = new vmath.vec3f args.gravity ? [0,-9.8,0]          # acceleration of gravity
    @bounce_dump = new vmath.vec2f args.bounce_dump ? [0.001,0.5] # loss of velocity at bounce (parallel,ortho)
    @gpu_skinning = args.gpu_skinning ? false                     # whether to skin on the gpu

scene.new_lookat_camera = (args) ->
  ret = new scene.Camera
  eye = if args.from? then new vmath.vec3f args.from else vmath.z3f.clone()
  center = if args.to? then new vmath.vec3f args.to else vmath.zero3f.clone()
  up = if args.up? then new vmath.vec3f args.up else vmath.y3f.clone()
  ret.frame = vmath.lookat_frame eye, center, up, true
  ret.width = args.width ? 1
  ret.height = args.height ? 1
  ret.dist = args.dist ? 1
  ret.focus = vmath.llength vmath.sub(eye,center)
  return ret

# scene comprised of a camera, a list of meshes,
# and a list of lights. rendering parameters are
# also included, namely the background color (color
# if a ray misses) the ambient illumination, the
# image resolution (image_width, image_height) and
# the samples per pixel (image_samples).
class scene.Scene
  constructor: (args = {}) ->
    @camera = new scene.Camera args.camera                                       # camera
    @camera = scene.new_lookat_camera(args.lookat_camera) if args.lookat_camera?  # lookat camera
    @meshes = if args.meshes? then (new scene.Mesh mesh for mesh in args.meshes) else []     # meshes
    @meshes.push (new scene.Mesh mesh for mesh in json.load_json(scene.scene_path + args.json_meshes))... if args.json_meshes?  #json_meshes
    @surfaces = if args.surfaces? then (new scene.Surface surface for surface in args.surfaces) else []   # surfaces
    @lights = if args.lights? then (new scene.Light light for light in args.lights) else []               # lights

    @background = if args.background? then new vmath.vec3f args.background else vmath.mul(vmath.one3f,0.2)  # background color
    @background_txt = args.draw_animated ? null                                                             # background texture
    @ambient = if args.ambient? then new vmath.vec3f args.ambient else vmath.mul(vmath.one3f,0.2)     # ambient illumination

    @animation = new scene.SceneAnimation args.animation                       # scene animation data

    @image_width = args.image_width ? 512                                       # image resolution in x
    @image_height = args.image_height ? 512                                     # image resolution in y
    @image_samples = args.image_samples ? 1                                     # samples per pixels in each direction

    @draw_wireframe = args.draw_wireframe ? false                               # whether to use wireframe for interactive drawing
    @draw_animated = args.draw_animated ? false                                 # whether to draw with animation
    @draw_gpu_skinning = args.draw_gpu_skinning ? false                         # whether skinning is performed on the gpu
    @draw_captureimage = args.draw_captureimage ? false                         # whether to capture the image in the next frame

    @path_max_depth = args.path_max_depth ? 2                                   # maximum path depth
    @path_sample_brdf = args.path_sample_brdf ? true                            # sample brdf in path tracing
    @path_shadows = args.path_shadows ? true                                    # whether to compute shadows

scene.json_parse_scene = (obj) ->
  return new scene.Scene obj

scene.scene_path = ""
scene.scene_filename = ""
# load a scene from a json file
scene.load_json_scene = (filename) ->
  [scene.scene_path..., scene.scene_filename] = filename.split "/"
  scene.scene_path = scene.scene_path.join "/"
  s = scene.json_parse_scene(json.load_json(filename))
  return s

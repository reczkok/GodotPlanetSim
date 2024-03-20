extends Node3D

@export var mass: float = 10.0
@export var size_offset: float = 1
var parent;
var vel: Vector3 = Vector3(0,0,0)
var radius
var grav_info: float = 1.0
var other_planets
var ang_vel

func init_rand(gravity: float, vel_normal, mass_normal, pos_normal,
 init_vel: Vector3 = Vector3(randf_range(-10.0, 10.0),randf_range(-10.0, 10.0), randf_range(-10.0, 10.0)),
 init_mass: float = randf_range(0.1,10.0),
 init_pos: Vector3 = Vector3(randf_range(-10.0, 10.0), randf_range(-10.0, 10.0), randf_range(-10.0, 10.0))):
	self.parent = get_parent()
	self.vel = init_vel*vel_normal
	self.mass = init_mass*mass_normal
	radius = calculateRadius()
	scale = Vector3(radius, radius, radius)
	parent.next_grav_step.connect(doStuff)
	self.grav_info = gravity
	self.transform.origin = init_pos*pos_normal	
	self.ang_vel = randf_range(0.0,0.2) * randf_range(0.0,0.1)
	
func init(gravity, init_vel, init_mass, init_pos):
	self.parent = get_parent()
	self.vel = init_vel
	self.mass = init_mass
	radius = calculateRadius()
	scale = Vector3(radius, radius, radius)
	parent.next_grav_step.connect(doStuff)
	self.grav_info = gravity
	self.transform.origin = init_pos
	self.ang_vel = randf_range(0.0,10.0)
	

func calculateRadius():
	return sqrt(mass)
	
func updatePlanetInfo(planet_info):
	self.other_planets = planet_info
	
func updateGravity(new_grav):
	self.grav_info = new_grav
	
func doStuff(delta):
	transform = transform.rotated_local(Vector3(0,1,0), ang_vel)
	var force = Vector3(0,0,0)
	for planet in other_planets:
		var dist_vec: Vector3 = planet.transform.origin - transform.origin
		var dist = dist_vec.length()
		if dist > (radius + planet.radius):
			var new_force = grav_info*(mass * planet.mass)/(dist*dist)
			var force_vec = dist_vec.normalized() * new_force
			force += force_vec
	
	vel += (force/mass)*delta
	transform.origin += (vel * delta)
	
func doStuffShader(data, delta, grav):
	pass

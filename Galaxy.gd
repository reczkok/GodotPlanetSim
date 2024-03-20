extends Node3D

@onready var planet_ref = preload("res://planet.tscn")
@export var step_delay: float = 0.5;
@export var num_of_planets: int = 10;
@export var gravity_strength: float = 0.1
@export var dist_mult: float = 1
@export var mass_mult: float = 1
signal next_grav_step(timestep);
var next_step: float;
var planets = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	next_step = step_delay
	for i in range(num_of_planets):
		var new_planet = planet_ref.instantiate()
		add_child(new_planet)
		new_planet.init_rand(gravity_strength, 5, 50, 15)
		planets.append(new_planet)
	for x in planets:
		x.updatePlanetInfo(planets)
#	var planet1 = planet_ref.instantiate()
#	add_child(planet1)
#	planet1.init(gravity_strength, Vector3(100,0,0), 200, Vector3(0,0,50))
#	planets.append(planet1)
#	var planet2 = planet_ref.instantiate()
#	add_child(planet2)
#	planet2.init(gravity_strength, Vector3(-100,0,0), 200, Vector3(0,0,-50))
#	planets.append(planet2)
#	planet1.updatePlanetInfo(planets)
#	planet2.updatePlanetInfo(planets)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if delta > step_delay:
		next_step = step_delay
		next_grav_step.emit(delta)
	else:
		if next_step > 0:
			next_step -= delta
		else:
			next_step = step_delay
			next_grav_step.emit(step_delay)



func _on_h_scroll_bar_gravity_setter(val):
	for x in planets:
		x.updateGravity(val)


func _on_button_new_planet_requested():
	var new_planet = planet_ref.instantiate()
	add_child(new_planet)
	new_planet.init_rand(gravity_strength, 5, 50, 15)
	planets.append(new_planet)
	for x in planets:
		x.updatePlanetInfo(planets)

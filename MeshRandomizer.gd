extends MeshInstance3D

@export var TEXTURE_VARIATIONS_ARRAY: Array = [
	preload("res://maps_planets/3r8nosrj.bmp"),
	preload("res://maps_planets/6uj1rzoq.bmp"),
	preload("res://maps_planets/7pemahja.bmp"),
	preload("res://maps_planets/9foqr7eb.bmp"),
	preload("res://maps_planets/ccbhozhw.bmp"),
	preload("res://maps_planets/d40g5rt1.bmp"),
	preload("res://maps_planets/kbzdg98z.bmp"),
	preload("res://maps_planets/kwwij78c.bmp"),
	preload("res://maps_planets/o0b9ce5g.bmp"),
	preload("res://maps_planets/oob6k6oo.bmp"),
	preload("res://maps_planets/oxu7932u.bmp"),
	preload("res://maps_planets/pk915273.bmp"),
	preload("res://maps_planets/u968u2uq.bmp"),
	preload("res://maps_planets/y5zq23rg.bmp")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var r = randi()%TEXTURE_VARIATIONS_ARRAY.size()
	var matt = StandardMaterial3D.new()
	matt.albedo_texture = TEXTURE_VARIATIONS_ARRAY[r]
	var new_mesh = SphereMesh.new()
	new_mesh.material = matt
	self.mesh = new_mesh


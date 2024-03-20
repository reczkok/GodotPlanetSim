extends Camera3D

@onready var parent = get_parent()
var funky_timer_def: float = 3
var funky_timer: float = -1.0
var funky_target
var camera_timer: float = -1.0
var camera_timer_def: float = 1
var vector1: Vector3 = self.transform.origin
var vector2: Vector3 = self.transform.origin
var look_target_sf
var funky_forced = false

func _input(event):
	if event.is_action_pressed("zoom_in"):
		self.fov -= 2.0
	if event.is_action_pressed("zoom_out"):
		if self.fov < 100:
			self.fov += 2.0
	if event.is_action_pressed("next_planet"):
		funky_timer = 0.0
	if event.is_action_pressed("funky_force"):
		if funky_forced:
			funky_forced = false
		else:
			funky_forced = true

func _process(delta):
	var new_pos = Vector3(0,0,0);
	var count = 0
	for x in parent.planets:
		var pos = x.transform.origin
		new_pos += pos
		count += 1
	new_pos /= count
	
	var is_clustered = false
	for x in parent.planets:
		var pos = x.transform.origin
		if pos.distance_to(new_pos) < 300:
			is_clustered = true
			
	if is_clustered and not funky_forced:
		normalFollow(new_pos, delta)
	else:
		funkyFollow(new_pos, delta)
	


func normalFollow(new_pos, delta):
	var new_new_pos = Vector3(0,0,0)
	var total = 0
	for x in parent.planets:
		var pos = x.transform.origin
		new_new_pos += pos * (1-(min(pos.distance_to(new_pos)/500, 1)))
		total += (1-(min(pos.distance_to(new_pos)/500, 1)))
	new_new_pos /= total
	var dist_to_vec = self.transform.origin.distance_to(new_new_pos)
#	if dist_to_vec > 201:
#		self.transform.origin = self.transform.origin.lerp(self.transform.origin.move_toward(new_pos, dist_to_vec - 200), 0.5)
#	elif dist_to_vec < 200:
#		self.transform.origin = self.transform.origin.lerp(self.transform.origin.move_toward(new_pos, dist_to_vec - 200), 0.5)
#	self.transform = self.transform.looking_at(new_pos)
	self.smooth_follow(new_new_pos, delta)
	
func funkyFollow(new_pos, delta):
	if funky_timer <= 0:
		funky_timer = funky_timer_def
		funky_target = parent.planets.pick_random()
	else:
		funky_timer -= delta
		var new_pos_f = funky_target.transform.origin
		var dist_to_vec = self.transform.origin.distance_to(new_pos_f)
		if dist_to_vec > 100:
			self.transform.origin = self.transform.origin.move_toward(new_pos_f, dist_to_vec - 100)
		self.transform = self.transform.looking_at(new_pos_f)

func smooth_follow(target, delta):
	if camera_timer < 0:
		camera_timer = camera_timer_def
		vector1 = vector2
		vector2 = vector1.move_toward(target, vector1.distance_to(target) - 200)
		if vector2.x == INF:
			vector2 = vector1
	else:
		camera_timer -= delta
		self.transform.origin = vector1.lerp(vector2, 1-camera_timer/camera_timer_def)
		self.transform = self.transform.looking_at(target)
		
		
		

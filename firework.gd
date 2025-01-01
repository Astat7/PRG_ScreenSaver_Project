extends Node2D

var gravity = Vector2(0, 250)

var velocity = Vector2(0, 0)
var start = Vector2(0, 0)
var target = Vector2(0, 0)
var travel_time = 1.5

var triggered = false

var primary_node

# do explosion animation
func trigger() -> void:
	if triggered == false:
		triggered = true
		
		var effect = load("res://explosion_effect_sphere.tscn")
		effect = effect.instantiate()
		effect.position = self.position
		
		primary_node.add_child(effect)
		effect.activate(get_node("Polygon2D").color)
		
		queue_free()

# launch firework at position
func activate(target_position, main_node) -> void:
	primary_node = main_node
	target = target_position
	
	var screen_size = primary_node.get_viewport().get_visible_rect().size
	self.position = Vector2(target_position.x+(randi_range(-screen_size.x*0.15, screen_size.x*0.15)), screen_size.y)
	start = self.position
	
	velocity = -(( (gravity*(travel_time*(travel_time*0.5))) + start - target ) / travel_time)
	
	self.process_mode = Node.PROCESS_MODE_INHERIT
	
	await primary_node.get_tree().create_timer(travel_time).timeout
	trigger()
	
func _ready() -> void:
	randomize()
	
	# give firework random color from a limited selection
	var color_a = randf_range(0, 1)
	var color_b = randf_range(0, 0.5)
	var color_c = randf_range(0.55, 1)
	var color
	match randi_range(0, 5):
		0:
			color = Color(color_a, color_b, color_c)
		1:
			color = Color(color_a, color_c, color_b)
		2:
			color = Color(color_b, color_a, color_c)
		3:
			color = Color(color_b, color_c, color_a)
		4:
			color = Color(color_c, color_b, color_a)
		5:
			color = Color(color_c, color_a, color_b)
	get_node("Polygon2D").color = Color(color)

func _process(delta: float) -> void:
	
	velocity += gravity * delta
	
	self.position += velocity * delta

	if velocity.y > -1:
		trigger()

extends Node2D

var particles = []
var directions = [Vector2(6, 0), Vector2(5, -3), Vector2(3, -5), Vector2(0, -6), Vector2(-3, -5), Vector2(-5, -3), Vector2(-6, 0), Vector2(-5, 3), Vector2(-3, 5), Vector2(0, 6), Vector2(3, 5), Vector2(5, 3)]
var alive_time = 1
var deacceleration = 1

# activate effect
func activate(color) -> void:
	for particle in particles:
		particle.color = color

func _ready() -> void:
	self.rotation_degrees = randf_range(0, 60)
	
	particles = self.get_children()
	print(particles)
	await get_tree().create_timer(alive_time).timeout
	
	queue_free()

func _process(_delta: float) -> void:
	var index = 0
	for particle in particles:
		particle.position += directions[index] / deacceleration
		
		index += 1
	deacceleration += 0.035

extends Node2D

var fw_scene = preload("res://firework.tscn")
var margin = 0.2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var firework = fw_scene.instantiate()
		
		firework.activate(event.position, self)
		add_child(firework)

func _ready() -> void:
	randomize()

func _process(_delta: float) -> void:
	
	# spawn fireworks randomly
	if randi_range(1, 60) == 1:
		var firework = fw_scene.instantiate()
		
		var screen_size = get_viewport().get_visible_rect().size
		var margin_x = screen_size.x * margin
		var margin_y = screen_size.y * margin
		var size_x = screen_size.x - margin_x
		var size_y = screen_size.y - margin_y
		
		firework.activate(Vector2(randi_range(margin_x, size_x), randi_range(margin_y, size_y)), self)
		add_child(firework)

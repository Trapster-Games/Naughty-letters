extends Node

onready var viewport = get_viewport()

var default_size = Vector2(2246, 1080)

func _ready():
	viewport.connect("size_changed", self, "window_resize")
	window_resize()

func window_resize():
	var current_size = OS.get_window_size()

	var scale_factor = default_size.y/current_size.y
	var new_size = Vector2(current_size.x*scale_factor, default_size.y)

	if new_size.x < default_size.x:
		scale_factor = default_size.x/new_size.x
		new_size = Vector2(default_size.x, new_size.y*scale_factor)

	viewport.set_size_override(true, new_size)

extends CanvasLayer


onready var animation_player = get_node("AnimationPlayer")
onready var black = get_node("Control/Black")

func change_scene(path, delay = 0):
	#self.set_layer(1)
	yield(get_tree().create_timer(delay), "timeout")
	
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("fade")
	yield(animation_player, "animation_finished")
	#self.set_layer(-1)

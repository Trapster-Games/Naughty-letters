extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_node("AnimationPlayer").play("logo")
	#get_node("AnimationPlayer").play_backwards("logo")
	
	SceneChanger.change_scene("res://Scenes/Menu/Menu.tscn", 2.3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

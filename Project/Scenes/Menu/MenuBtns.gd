extends Control

onready var CameraPosition:Position2D = get_parent().get_node(("CameraPosition"));
onready var MenuOptions = {
	"Main" : get_node("Main"),
	"Play" : get_node("Play"),
	"Custom": get_node("Custom"),
	"Settings":get_node("Settings"),
	"How_to":get_node("How to")
}

func _ready():
	_HideExcept("Main") #Hide all elements except the main menu
	_CameraMove(Vector2(1123,540))

func _HideExcept(except): #works (also) as signal for the buttons
	print("CurrentMenuMode: " + except)
	for i in MenuOptions:
		if i == except: MenuOptions[i].show()
		else: MenuOptions[i].hide()

func _CameraMove(coords):
	# 1802, 540 -> setting-positined
	# 1123, 540 -> normal positioned 
	CameraPosition.set_global_position(coords)
	pass # Replace with function body.

extends TextureRect

var darkmode = preload("res://assets/artwork/Export/darkmode_background.png")
var default = preload("res://assets/artwork/Export/background.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	_setDarkOrDefault() # Replace with function body.

func _setDarkOrDefault():
	if Settings.get_setting("General", "DarkMode") == true:
		self.set_texture(darkmode)
	else:
		self.set_texture(default)

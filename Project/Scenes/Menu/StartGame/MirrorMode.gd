extends CheckButton

func _ready():
	self.set_pressed(Settings.get_setting("Game", "MirrorMode"))


func _on_MirrorMode_toggled(button_pressed):
	Settings.set_setting("Game", "MirrorMode", button_pressed)

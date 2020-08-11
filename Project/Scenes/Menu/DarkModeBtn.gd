extends CheckButton

onready var backgroundPicture = get_node("/root/NaughtyLetters/Background/Background_Image")

func _ready():
	if Settings.get_setting("General", "DarkMode") == true:
		self.set_pressed(true)
	else: self.set_pressed(false)
	
func _SaveGeneralSettings():
	Settings.save_settings()


func _on_DarkMode_toggled(button_pressed):
	Settings.set_setting("General", "DarkMode", button_pressed)
	print("changed value")
	backgroundPicture._setDarkOrDefault()
	#set other settings
	

extends CheckButton

onready var backgroundPicture = get_node("/root/NaughtyLetters/Background_sizable/Background_Image")
onready var CardDecks =get_node("/root/NaughtyLetters/Menu/Play/Options/DecksContner").get_children()

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
	
	for deck in CardDecks:
		if deck is CheckButton:
			if button_pressed:
				deck.add_color_override("font_color_pressed", Color("#000000"))
			else:
				deck.add_color_override("font_color_pressed", Color("#fc8a0f"))
	

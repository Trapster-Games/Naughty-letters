extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for category in self.get_children():
		if category is CheckButton:
			if Settings.get_setting("Game", "Decks").has(category.text):
				category.set_pressed(true)


func _save_settings():
	var takenCategories = []
	for category in self.get_children():
		if category is CheckButton and category.pressed == true:
			takenCategories.append(category.text)
	Settings.set_setting("Game", "Decks", takenCategories)
	Settings.save_settings()

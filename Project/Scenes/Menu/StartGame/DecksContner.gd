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

func _category_toggled():
	var takenCategories = []
	for category in self.get_children():
		if category is CheckButton and category.pressed == true:
			takenCategories.append(category.text)
	Settings.set_setting("Game", "Decks", takenCategories)
	Settings.save_settings()
	if takenCategories.size() <= 0:
		get_parent().get_parent().get_node("StartBtn").set_disabled(true)
	else:
		get_parent().get_parent().get_node("StartBtn").set_disabled(false)

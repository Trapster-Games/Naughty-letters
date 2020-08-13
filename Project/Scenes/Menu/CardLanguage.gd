extends TextureButton

onready var languages = {
	"English": preload("res://assets/artwork/Export/Options/english.png"),
	"German": preload("res://assets/artwork/Export/Options/german.png")
}


# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_normal_texture(languages[Settings.get_setting("General", "CardLanguage")])


#switches settings
func _on_CardLanguage_pressed():
	var current = 0
	while true:
		if languages.keys()[current] == Settings.get_setting("General", "CardLanguage"):
			Settings.set_setting("General", "CardLanguage", languages.keys()[(current+1)%languages.size()])
			Settings.syncStaticCategories()
			self.set_normal_texture(languages[languages.keys()[(current+1)%languages.size()]])
			
			break
		current += 1

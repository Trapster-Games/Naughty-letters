extends Label


func _ready():
	self.set_text(str(Settings.get_setting("Game", "Rounds")))


func _AddRound():
	if Settings.get_setting("Game", "Rounds") < 90:
		Settings.set_setting("Game", "Rounds", Settings.get_setting("Game", "Rounds")+5)
		self.set_text(str(Settings.get_setting("Game", "Rounds")))
	else:
		Settings.set_setting("Game", "Rounds", 95)
		self.set_text(str(Settings.get_setting("Game", "Rounds")))

func _RemoveRound():
	if Settings.get_setting("Game", "Rounds") > 10:
		Settings.set_setting("Game", "Rounds", Settings.get_setting("Game", "Rounds")-5) 
		self.set_text(str(Settings.get_setting("Game", "Rounds")))
	else:
		Settings.set_setting("Game", "Rounds", 5)
		self.set_text(str(Settings.get_setting("Game", "Rounds")))

extends Label


func _ready():
	self.set_text(str(Settings.get_setting("Game", "Rounds")))


func _AddRound():
	Settings.set_setting("Game", "Rounds", Settings.get_setting("Game", "Rounds")+1)
	self.set_text(str(Settings.get_setting("Game", "Rounds")))

func _RemoveRound():
	if Settings.get_setting("Game", "Rounds") > 0:
		Settings.set_setting("Game", "Rounds", Settings.get_setting("Game", "Rounds")-1) 
		self.set_text(str(Settings.get_setting("Game", "Rounds")))

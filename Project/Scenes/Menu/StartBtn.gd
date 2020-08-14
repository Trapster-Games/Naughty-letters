extends TextureButton




func _on_StartBtn_pressed():
	Settings.save_settings()
	SceneChanger.change_scene("res://Scenes/Game/Game.tscn")

extends GridContainer

var delete_picture = preload("res://assets/artwork/Export/MainMenu/Delete_Btn.png")
onready var AddCategoryContainer = get_node("CenterContainer")
func _ready():
	DrawCustom()

func DrawCustom():
	# create a lineEdit 
	for category in Settings.get_setting("Categories", "Custom"):
		CreateLineEditDelete(category)
	
func CreateLineEditDelete(text):
	var node = LineEdit.new()
	node.text = text
	node.rect_min_size = Vector2(600,120)
	add_child(node)
	
	var Delete_btn = TextureButton.new()
	Delete_btn.set_normal_texture(delete_picture)
	Delete_btn.set_position(Vector2(600, -5))
	Delete_btn.set_scale(Vector2(1,1))
	Delete_btn.connect("pressed", self, "_removeLineEdit", [Delete_btn])#todo: points to wrong method
	node.add_child(Delete_btn)
	# so the addcategory button is on the bottom of the gridcontainer
	self.move_child(AddCategoryContainer, self.get_child_count())

func _saveCategories():
	var nodeText = []
	for node in self.get_children():
		print(node)
		if node != null and node is LineEdit:
			if node.get_text() != "":
				nodeText.append(node.get_text())
	Settings.set_setting("Categories", "Custom", nodeText)
	Settings.save_settings()

#if a delete btn is pressed, a lineedit should be removed
func _removeLineEdit(node):
	node.get_parent().queue_free()



func _on_AddCategory_pressed():
	CreateLineEditDelete("")

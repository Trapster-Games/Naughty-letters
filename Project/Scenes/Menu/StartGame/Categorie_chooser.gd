extends CheckButton

onready var cnt_cardsLabel = get_node("cards")

# Called when the node enters the scene tree for the first time.
func _ready():
	_initCategoryCount()

func _initCategoryCount():
	cnt_cardsLabel.set_text(str(Settings.get_setting("Categories", self.text).size()) + " cards")

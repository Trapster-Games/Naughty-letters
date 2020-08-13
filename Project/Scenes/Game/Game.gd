extends Control

const Alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
var SpinAlphabet = []
var Category = []
var Activedeck = Settings.get_setting("Game", "Decks").duplicate(true) # duplicate(true) so it wont affect the original array
var AllDecks = Settings.settings["Categories"].duplicate(true)# same as above
var currentRound = -1

func set_category(value):
	for label in Category:
		label.set_text(value)

func set_letter(value):
	for label in SpinAlphabet:
		label.set_text(value)


# Called when the node enters the scene tree for the first time.
func _ready():
	if Settings.get_setting("Game", "MirrorMode") == true:
		
		get_node("Mirrored").show()
		get_node("NonMirrored").hide()
		
		SpinAlphabet.append(get_node("Mirrored/SpinAlphabet"))
		SpinAlphabet.append(get_node("Mirrored/SpinAlphabetMirrored"))
		Category.append(get_node("Mirrored/Category"))
		Category.append(get_node("Mirrored/CategoryMirrored"))
	else:
		get_node("Mirrored").hide()
		get_node("NonMirrored").show()
		
		SpinAlphabet.append(get_node("NonMirrored/SpinAlphabet"))
		Category.append(get_node("NonMirrored/Category"))
	
	_on_NextCategory_pressed()

func _on_SpinAlphabet_pressed():
	for i in range(25):
		var currentLetter = Alphabet[randi() % Alphabet.size()]
		set_letter(currentLetter)
		yield(get_tree().create_timer(i/100.0), "timeout")


#handles the switch of categorys, if all categorys are played once, it will start again
func _on_NextCategory_pressed():
	
	if currentRound > Settings.get_setting("Game", "Rounds"):
		SceneChanger.change_scene("res://Scenes/Menu/Menu.tscn")
	currentRound += 1
	
	if Activedeck.size() <= 0:
		Activedeck =  Settings.get_setting("Game", "Decks").duplicate(true)
		AllDecks = Settings.settings["Categories"].duplicate(true)
	
	var currentActive = Activedeck[randi() % Activedeck.size()]
	var CurrentDeck = AllDecks[currentActive]
	var currentCategory

	# if there is a category without cards
	if CurrentDeck.size() > 0:
		currentCategory = CurrentDeck[randi() % CurrentDeck.size()]
	else: #then delete this category from the current deck and call function again
		Activedeck.erase(currentActive)
		_on_NextCategory_pressed()
		return
	
	AllDecks[currentActive].erase(currentCategory)
	set_category(currentCategory)


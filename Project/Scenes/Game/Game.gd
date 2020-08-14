extends Control

const Alphabet = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
var SpinAlphabet = []
var Category = []
var TimeNodes = []
var Activedeck = Settings.get_setting("Game", "Decks").duplicate(true) # duplicate(true) so it wont affect the original array
var AllDecks = Settings.settings["Categories"].duplicate(true)# same as above
var currentRound = 1
var stop_count #for time counting (if the spin button is pressed again)
	
func set_category(value):
	for label in Category:
		label.set_text(str(value))

func set_letter(value):
	for label in SpinAlphabet:
		label.set_text(str(value))

func set_remaining_time(value):
	for label in TimeNodes:
		label.set_text(str(value))


# Called when the node enters the scene tree for the first time.
func _ready():
	if Settings.get_setting("Game", "MirrorMode") == true:
		
		get_node("Mirrored").show()
		get_node("NonMirrored").hide()
		
		SpinAlphabet.append(get_node("Mirrored/SpinAlphabet"))
		SpinAlphabet.append(get_node("Mirrored/SpinAlphabetMirrored"))
		Category.append(get_node("Mirrored/Category"))
		Category.append(get_node("Mirrored/CategoryMirrored"))
		TimeNodes.append(get_node("Mirrored/Seconds"))
		TimeNodes.append(get_node("Mirrored/SecondsMirrored"))
	else:
		get_node("Mirrored").hide()
		get_node("NonMirrored").show()
		
		SpinAlphabet.append(get_node("NonMirrored/SpinAlphabet"))
		Category.append(get_node("NonMirrored/Category"))
		TimeNodes.append(get_node("NonMirrored/Seconds"))
	
	_on_NextCategory_pressed()

func _on_SpinAlphabet_pressed():
	get_node("NextCategory").set_disabled(true)
	#alphabet spinning
	for i in range(25):
		set_remaining_time("5 sec")
		stop_count = true
		var currentLetter = Alphabet[randi() % Alphabet.size()]
		set_letter(currentLetter)
		yield(get_tree().create_timer(i/100.0), "timeout")
	
	get_node("NextCategory").set_disabled(false)
	
	stop_count = false
	#timer
	for i in range(5,-1,-1):
		if stop_count == true: #if the button is pressed multiple times, only count the last time
			set_remaining_time("5 sec")
			break;
		yield(get_tree().create_timer(1.0), "timeout")
		set_remaining_time(str(i) + " sec")

#handles the switch of categorys, if all categorys are played once, it will start again
func _on_NextCategory_pressed():
	stop_count = true #so the timer won't continue counting
	
	if Settings.get_setting("Game", "Rounds") < currentRound:
		SceneChanger.change_scene("res://Scenes/Menu/Menu.tscn")
		return
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
		currentRound-=1
		_on_NextCategory_pressed()
		return
	
	AllDecks[currentActive].erase(currentCategory)
	set_category(currentCategory)


extends Node

#const SAVE_PATH = "res://config.cfg" # in debug
const SAVE_PATH = "user://config.cfg" # on build

var config_file = ConfigFile.new()

const Categories = {
		"Family" : ["A Car brand", "A famous company", "A bad movie", "A TV-Series", "The best food", "A comic character", "How you would name your pet", "Where you would win at the Olympics", "A famous band", "A color", "The best candy", "An animal", "What you wish to get from Santa", "Something really boring", "I love _"],
		"Adults" : ["Why we need guns", "Something you do drunk", "Where you hide your drugs", "An offensive word", "Reason you hate your parents", "Another word for kill", "Trump's next genious move will be...", "Pet's name for the person next to you", "A killing device", "The best alcohol/drink", "Name for the next designer drug", "What you hate at your job", "Your hangover cure", "A name you call your ex", "Don't text this to your ex", "_ is bullshit"],
		"Naughty" : ["Things that happen in Vegas", "Bad time to get a boner", "Something you do when you are alone", "Your favourite porn category", "Something very wet", "Another word for penis", "Another word for vagina", "A celebrity you would bang", "A place you hide your sex toys", "The best sex toy", "Best name for a porn star", "Another word for doing it", "Something that turns you on", "Something that turns you off", "The best place to have sex", "Something sticky", "What you would like to do to the person next to you", "Weird place to be naked", "Somebody you don't want to have a wet dream of", "Something even better than sex", "Your most erogenous area", "I'm sure there is a fetish for _", "Something you can be tied up with", "Don't scream this during sex", "Something to roleplay as", "A sexual position", "A thing you can put inside of you", "Best song to have sex to", "Something hairy", "What you do after an orgasm", "Your favourite body part", "The best pornsite", "Where you should not wax yourself", "Fuck _", "What to wear to look sexy", "The first time feels like _"]
		#"Family" : ["FamilyCard", "Family2"], #for debug purposes
		#"Adults" : ["adult1", "adult2"],
		#"Naughty": ["naughty1", "naughty2"]
}

var settings = {
	"Categories" : {
		"Custom" : [],
		"Family" : [],
		"Adults" : [],
		"Naughty" : []
	},
	"General" :{
		"DarkMode" : false
	},
	"Game" : {
		"Rounds" : 15,
		"MirrorMode" : true,
		"Decks" : ["Family", "Adults", "Naughty", "Custom" ]
	}
}
 
func _ready():
	#save_settings()
	load_settings()
	syncStaticCategories()
	
#so the user have the always the latest categorys 
func syncStaticCategories():
	for sCategory in Categories:
		set_setting("Categories", sCategory, Categories[sCategory])

func save_settings():
	for section in settings.keys():
		for key in settings[section]:
			config_file.set_value(section, key, settings[section][key])
	
	config_file.save(SAVE_PATH)
	print("successfully saved settings")

func load_settings():
	# Open the file
	var error = config_file.load(SAVE_PATH)
	
	# Check if it opened
	if error != OK:
		print("Failed loading settings file. Error code %s" % error)
		print("Creating a new one...")
		save_settings()
		return
	
	# Retrieve the values and store them in settings
	for section in settings.keys():
		for key in settings[section]:
			var value = config_file.get_value(section, key, "")
			
			# if there is no value set, save a new config file
			if str(value) == "":
				save_settings()
				return
			
			settings[section][key] = value

func get_setting(category, key):
	return settings[category][key]

func set_setting(category, key, value):
	settings[category][key] = value



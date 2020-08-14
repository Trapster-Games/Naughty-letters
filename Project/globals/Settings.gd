extends Node

#const SAVE_PATH = "res://config.cfg" # in debug
const SAVE_PATH = "user://config.cfg" # on build

var config_file = ConfigFile.new()

const Categories = {
	"English" : {		
		"Family" : ["A Car brand", "A famous company", "A bad movie", "A TV-Series", "The best food", "A comic character", "How you would name your pet", "Where you would win at the Olympics", "A famous band", "A color", "The best candy", "An animal", "What you wish to get from Santa", "Something really boring", "I love _", "A category that should be added at the Oscars", "A Disney movie", "The worst time to fart", "A profession", "A boy's name", "A girl's name", "A kind of sport", "A celebrity", "A famous actor/actress", "A thing with wheels", "A country", "A musical instrument", "A vegetable", "A reptile", "A candy bar name", "A superhero", "A popular store", "Something you have in a kitchen", "Something you need for school", "Something you put in your burger", "A video game", "An indoor sport", "Something yellow", "Something blue", "Something red", "Something you don't want to miss on a vacation", "An insect" ,"A body part", "A city"],
		"Adults" : ["Why we need guns", "Something you do drunk", "Where you hide your drugs", "An offensive word", "Reason you hate your parents", "Another word for kill", "Trump's next genious move will be _", "Pet's name for the person next to you", "A killing device", "The best alcohol/drink", "Name for the next designer drug", "What you hate at your job", "Your hangover cure", "A name you call your ex", "Don't text this to your ex", "_ is bullshit"],
		"Naughty" : ["Things that happen in Vegas", "Bad time to get a boner", "Something you do when you are alone", "Your favourite porn category", "Something very wet", "Another word for penis", "Another word for vagina", "A celebrity you would bang", "A place you hide your sex toys", "The best sex toy", "Best name for a porn star", "Another word for doing it", "Something that turns you on", "Something that turns you off", "The best place to have sex", "Something sticky", "What you would like to do to the person next to you", "Weird place to be naked", "Somebody you don't want to have a wet dream of", "Something even better than sex", "Your most erogenous area", "I'm sure there is a fetish for _", "Something you can be tied up with", "Don't scream this during sex", "Something to roleplay as", "A sexual position", "A thing you can put inside of you", "Best song to have sex to", "Something hairy", "What you do after an orgasm", "Your favourite body part", "The best pornsite", "Where you should not wax yourself", "Fuck _", "What to wear to look sexy", "The first time feels like _"]
	},
	"German" : {
		"Family" : ["Eine Automarke", "Eine berühmte Firma", "ein schlechter Film", "Eine TV-Serie", "Das beste Essen", "Ein Comic Character", "Wie du dein Tier nennen würdes", "Wo du bei den Olympischen Spielen gewinnen würdest", "Eine berühmte Band", "Eine Farbe", "Die beste Süßigkeit", "Ein Tier", "Was du dir zu Weihnachten wünschst", "Etwas sehr langweiliges", "Ich liebe _", "Eine Kategorie, die zu den Oscars hinzugefügt werden sollte", "Ein Disney Film", "Der schlechteste Zeitpunkt um zu furzen", "Ein Beruf", "Ein Jungenname", "Ein Mädchenname", "Eine Sportart", "Eine Berühmtheit", "Ein/e berühmter Schauspieler/in", "Ein Ding mit Rädern", "Ein Land", "Ein Musikinstrument", "Ein Gemüse", "Ein Reptil", "Name eines Schokoriegels", "Ein Superheld", "Ein berühmtes Geschäft", "Was man in der Küche hat", "Was nab für die Schule braucht", "Was du in deinen Burger gibst", "Ein Computerspiel", "Eine Hallensportart", "Etwas Gelbes", "Etwas Blaues", "Etwas Rotes", "Was du im Urlaub nicht verpassen möchtest", "Ein Insekt" ,"Ein Körperteil", "Eine Stadt"],
		"Adults" : ["Warum wir Waffen brauchen", "Etwas, was du betrunken machst", "Wo du Drogen versteckst", "Ein unfreundliches Wort", "Was du an deinen Eltern nicht magst", "Ein anderes Wort für töten", "Trump's nächster genialer Schachzug wird _ sein", "Name des Haustiers für die Person neben dir", "Ein Tötungsgerät", "Das beste Getränk", "Name der nächsten Designerdroge", "Was du an deinem Job hasst", "Deine Katerkur", "Wie du deinen ex nennst", "Was du nicht deinem ex schreiben solltest", "_ ist Blödsinn"],
		"Naughty" : ["Was in Vegas passiert", "Schlechter Zeitpunkt für einen Ständer", "Was man tut, wenn man alle-ine ist", "Deine lieblings Pornkategorie", "Something very wet", "Ein anderes Wort für Penis", "Ein anderes Wort für Vagina", "Eine Berühmtheit, mit der du Sex haben würdest", "Ein Ort an dem du Sexspielzeuge versteckst", "Das beste Sexspielzeug", "Der beste Name für einen Pornstar", "Ein anderes Wort für es treiben", "Was dich anturnt", "Was dich abturnt", "Der beste Ort für Sex", "Etwas klebriges", "Was du mit der Person neben dir machen würdest", "Ein komischer Ort, um Nackt zu sein", "Jemand, von dem du keinen feuchten Traum haben möchtest", "etwas besseres als Sex", "Deine erogenste Zone", "Es gibt sicher einen Fetisch für _", "Etwas, mit dem du festgebunden werden kannst", "Schrei das nicht beim Sex", "Etwas zum Rollenspiel als", "Eine sexuelle Stellung", "Etwas, das du in dich stecken kannst", "Das beste Lied, um Sex zu haben", "Etwas haariges", "Was du nach einem Orgasmus machst", "Dein liebster Körperteil", "Die beste Pornseite", "Wo du dich nicht waxxen solltest", "Scheiß _", "Was du trägst um sexy auszusehen", "Das erste Mal fühlt sich wie _ an"]

	}
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
		"DarkMode" : false,
		"CardLanguage" : "English"
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
	for sCategory in Categories[get_setting("General", "CardLanguage")]:
		set_setting("Categories", sCategory, Categories[get_setting("General", "CardLanguage")][sCategory])

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



extends RichTextLabel

export(String, MULTILINE) var english_text
export(String, MULTILINE) var JP_text

func setText(text: String):
	clear()
	add_text(text)

# Called when the node enters the scene tree for the first time.
func _ready():
	#connect to language change
	Global.connect("language_changed", self, "_on_Global_language_changed")
	update_text()
	pass # Replace with function body.

#update text based on what the current language is
func update_text():
	if(Global.language == "Japanese"):
		setText(JP_text)
	elif(Global.language == "English"):
		setText(english_text)

func _on_Global_language_changed():
	update_text()

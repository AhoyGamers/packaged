extends RichTextLabel

export(String, MULTILINE) var english_text
export(String, MULTILINE) var JP_text

func setText(text: String):
	clear()
	add_text(text)

func _on_Test_end_level(totals):
	if(Global.language == "English"):
		setText(english_text)
	elif(Global.language == "Japanese"):
		setText(JP_text)
	pass # Replace with function body.

extends Control

var player_words = []
#var template = [
#		{
#		"prompts" : ["a name", "a noun", "adverb", "adjective"],
#		"story":"Once upon a time..%s, %s, %s %s"
#		},
#		{
#		"prompts" : ["a name", "a noun", "adverb", "adjective"],
#		"story":"There is a %s, %s, %s %s"
#		}
#		]
var current_story = {}		

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText


func _ready() -> void:
		set_current_story()
		DisplayText.text = "Welcomeee !! "
		check_player_words_length()
		PlayerText.grab_focus()
func set_current_story():
	var stories = get_from_json("StoryBook.json")
	randomize()
	current_story = stories[randi() % stories.size()]
#	var stories = $StoryBook.get_child_count()
#	var selected_story = randi() % stories
#	print(selected_story)
#	current_story = $StoryBook.get_child(selected_story)
	#current_story.story = $StoryBook.get_child(selected_story).story
#	current_story = template[randi() % template.size() ]
func get_from_json(filename):
	var file = File.new()
	file.open((filename), File.READ)
	var text = file.get_as_text() #read as a text
	var data = parse_json(text)
	file.close()
	return data
func _on_PlayerText_text_entered(new_text: String) -> void:
	add_to_player_words()
#	update_DisplayText(new_text)


func _on_TextureButton_pressed() -> void:
	if  is_story_done():
		get_tree().reload_current_scene()

	else:	
		add_to_player_words()
#	var words = PlaeyerText.text
#	update_DisplayText(words)

#func update_DisplayText(new_text: String) -> void:
#	DisplayText.text = new_text
#	PlaeyerText.clear()
	
func add_to_player_words():
	player_words.append(PlayerText.text)
	PlayerText.clear()
	DisplayText.text = ""
	check_player_words_length()
func is_story_done():
	return player_words.size() == current_story.prompts.size()	#return true false
	

func check_player_words_length():
	if  is_story_done():
		end_game()
	else:
		prompt_player()
func tell_story():
	DisplayText.text = current_story.story % player_words

	
func prompt_player():
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + " please?"		
	
func end_game():
	PlayerText.queue_free()
	$VBoxContainer/HBoxContainer/Label.text = "Again!"
	tell_story()
		
	
	

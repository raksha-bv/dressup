extends Node2D

const CORRECT_ITEMS = {
	"hat": "Hat",    
	"shirt": "Shirt", 
	"pant": "Pant",
	"shoe": "Shoes"   
}

func _process(delta: float) -> void:
	AudioPlayer.play_music()

func _on_button_pressed():

	var worn_hats = get_tree().get_nodes_in_group("worn_hat")
	var worn_shirts = get_tree().get_nodes_in_group("worn_shirt")
	var worn_pants = get_tree().get_nodes_in_group("worn_pants")
	var worn_shoes = get_tree().get_nodes_in_group("worn_shoe")

	if worn_hats.size() == 0 or worn_shirts.size() == 0 or worn_pants.size() == 0 or worn_shoes.size() == 0:
		return
		
	var is_all_correct = true
	

	var current_hat = worn_hats[0]
	if current_hat.name != CORRECT_ITEMS["hat"]:
		print("hat not ok")
		is_all_correct = false
	

	var current_shirt = worn_shirts[0]
	if current_shirt.name != CORRECT_ITEMS["shirt"]:
		print("shirt not ok")
		is_all_correct = false
	

	var current_pants = worn_pants[0]
	if current_pants.name != CORRECT_ITEMS["pant"]:
		print("pant not ok")
		is_all_correct = false
	
	var current_shoe = worn_shoes[0]
	if current_shoe.name != CORRECT_ITEMS["shoe"]:
		print("shoe not ok")
		is_all_correct = false
	
	if is_all_correct:
		show_win_screen()
	else:
		show_game_over_screen()



func show_win_screen():
	AudioPlayer.play_win()
	get_tree().change_scene_to_file("res://scenes/win.tscn")

func show_game_over_screen():
	AudioPlayer.play_game_over()
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

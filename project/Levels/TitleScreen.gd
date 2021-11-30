extends Node2D


func _on_StartButton_pressed():
	var _ignored = get_tree().change_scene("res://Levels/Main/Level.tscn")


func _on_Instructions_pressed():
	$InstructionsPopup.popup()

extends Node2D


func _on_RestartButton_pressed():
	 var _ignored = get_tree().change_scene("res://src/TitleScreen.tscn")

extends Control


func _on_RestartButton_pressed():
	 var _ignored = get_tree().change_scene("res://src/TitleScreen.tscn")


func update_weapons(primary_weapon, secondary_weapon):
	$SecondaryWindow/Weapon.texture = secondary_weapon.get_texture()
	$PrimaryWindow/Weapon.texture = primary_weapon.get_texture()


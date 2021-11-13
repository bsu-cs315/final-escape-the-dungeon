extends Control


const KEY_OUTLINE := "res://assets/Items/key_outline.png"
const KEY_TEXTURED := "res://assets/Items/key.png"


func _on_RestartButton_pressed():
	 var _ignored = get_tree().change_scene("res://src/TitleScreen.tscn")


func update_weapons(primary_weapon, secondary_weapon):
	$SecondaryWindow/Weapon.texture = secondary_weapon.get_texture()
	$PrimaryWindow/Weapon.texture = primary_weapon.get_texture()


func update_key_count(value):
	$KeyLabel.text = "x" + str(value)
	if value == 0:
		$KeyLogo.texture = load(KEY_OUTLINE)
	else:
		$KeyLogo.texture = load(KEY_TEXTURED)

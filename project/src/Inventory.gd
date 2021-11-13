extends Control


func _ready():
	visible = false


func _on_ResumeButton_pressed():
	get_parent().unpause()


func _on_RestartButton_pressed():
	var _ignored = get_tree().change_scene("res://src/Level.tscn")


func _on_TitleButton_pressed():
	var _ignored = get_tree().change_scene("res://src/TitleScreen.tscn")
	

func show_inventory(primary_weapon, secondary_weapon, health_amount, key_count):
	visible = true
	$PrimaryWeapon.texture = primary_weapon.get_texture()
	$SecondaryWeapon.texture = secondary_weapon.get_texture()
	$HealthLabel.text = str(health_amount) + "/5"
	$KeyLabel.text = "x" + str(key_count)


func hide_inventory():
	visible = false

extends Control


const KEY_OUTLINE := "res://Levels/Main/Items/key_outline.png"
const KEY_TEXTURED := "res://Levels/Main/Items/key.png"
const INDEX := 100


func _on_RestartButton_pressed():
	 var _ignored = get_tree().change_scene("res://Levels/TitleScreen.tscn")


func update_weapons(primary_weapon, secondary_weapon, is_switch):
	$SecondaryWindow/Weapon.texture = secondary_weapon.get_texture()
	$PrimaryWindow/Weapon.texture = primary_weapon.get_texture()
	if is_switch:
		$PrimaryAnimation.stop()
		$PrimaryAnimation.play("grow")


func update_key_count(value):
	$KeyLabel.text = "x" + str(value)
	if value == 0:
		$KeyLogo.texture = load(KEY_OUTLINE)
	else:
		$KeyLogo.texture = load(KEY_TEXTURED)
	var particles = load("res://Characters/Player/ArrowParticles.tscn").instance()
	particles.texture = load("res://Levels/Main/Items/key_particle.png")
	particles.position = $KeyLogo.position
	particles.emitting = true
	particles.z_index = INDEX
	get_parent().call_deferred("add_child", particles)

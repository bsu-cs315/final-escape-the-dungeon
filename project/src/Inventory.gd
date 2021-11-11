extends Control


func _ready():
	visible = false
	

func show_inventory(primary_weapon, secondary_weapon, health_amount, key_count):
	visible = true
	$PrimaryWeapon.texture = primary_weapon.texture
	$SecondaryWeapon.texture = secondary_weapon.texture
	$HealthLabel.text = str(health_amount) + "/5"
	$KeyLabel.text = "x" + str(key_count)


func hide_inventory():
	visible = false

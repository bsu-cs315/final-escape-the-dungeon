extends Area2D


const BRAND := "Longsword"
const NORMAL_PATH := "res://Assets/Swords/Longsword.png"
const IRON_PATH := "res://Assets/Swords/Iron Longsword.png"
const GOLD_PATH := "res://Assets/Swords/Golden Longsword.png"
const NORMAL_DAMAGE := 1
const IRON_DAMAGE := 2
const GOLD_DAMAGE := 3


var type := "Normal"
var damage := NORMAL_DAMAGE


func update_type(new_type):
	type = new_type
	if type == "Golden":
		$Sprite.texture = load(GOLD_PATH)
		damage = GOLD_DAMAGE
	elif type == "Iron":
		$Sprite.texture = load(IRON_PATH)
		damage = IRON_DAMAGE

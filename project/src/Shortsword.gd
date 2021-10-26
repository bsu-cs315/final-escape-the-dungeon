extends Area2D

const BRAND = "Shortsword"
const NORMAL_PATH := "res://Assets/Swords/Shortsword.png"
const IRON_PATH := "res://Assets/Swords/Iron Shortsword.png"
const GOLD_PATH := "res://Assets/Swords/Golden Shortsword.png"


var type := "Normal"


func updateType(new_type):
	type = new_type
	if type == "Golden":
		$Sprite.texture = load(GOLD_PATH)
	elif type == "Iron":
		$Sprite.texture = load(IRON_PATH)

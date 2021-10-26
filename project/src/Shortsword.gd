extends Area2D


const BRAND := "shortsword"
const NORMAL_PATH := "res://Assets/Swords/Shortsword.png"
const IRON_PATH := "res://Assets/Swords/Iron Shortsword.png"
const GOLD_PATH := "res://Assets/Swords/Golden Shortsword.png"


var type := "normal"

func _ready():
	#sword.construct(type, BRAND)
	pass
	
func updateType(new_type):
	type = new_type
	if type == "golden":
		$Sprite.texture = load(GOLD_PATH)
	elif type == "iron":
		$Sprite.texture = load(IRON_PATH)
	#sword.construct(type, BRAND)

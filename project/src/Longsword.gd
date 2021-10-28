extends Area2D


const NORMAL_PATH := "res://Assets/Swords/Longsword.png"
const IRON_PATH := "res://Assets/Swords/Iron Longsword.png"
const GOLD_PATH := "res://Assets/Swords/Golden Longsword.png"
const NORMAL_DAMAGE := 1
const IRON_DAMAGE := 2
const GOLD_DAMAGE := 3


export var position_extension := 20
export var damage := NORMAL_DAMAGE
export var weapon_type = "Longsword"


var type := "Normal"


func _on_AnimationPlayer_animation_finished(_anim_name):
	get_parent().remove_weapon()
	queue_free()


func update__type(new_type):
	type = new_type
	if type == "Golden":
		$Sprite.texture = load(GOLD_PATH)
		damage = GOLD_DAMAGE
	elif type == "Iron":
		$Sprite.texture = load(IRON_PATH)
		damage = IRON_DAMAGE


func attack():
	$AnimationPlayer.play("Attack")

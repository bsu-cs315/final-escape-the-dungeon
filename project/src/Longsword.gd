extends Area2D


const BRAND := "Longsword"
const NORMAL_PATH := "res://Assets/Swords/Longsword.png"
const IRON_PATH := "res://Assets/Swords/Iron Longsword.png"
const GOLD_PATH := "res://Assets/Swords/Golden Longsword.png"
const NORMAL_DAMAGE := 1
const IRON_DAMAGE := 2
const GOLD_DAMAGE := 3


var type := "Normal"
export var damage := NORMAL_DAMAGE


var _is_attacking := false


func _ready():
	visible = false


func _on_AnimationPlayer_animation_finished(_anim_name):
	_is_attacking = false
	visible = false


func update_type(new_type):
	type = new_type
	if type == "Golden":
		$Sprite.texture = load(GOLD_PATH)
		damage = GOLD_DAMAGE
	elif type == "Iron":
		$Sprite.texture = load(IRON_PATH)
		damage = IRON_DAMAGE


func attack():
	if _is_attacking:
		return
	visible = true
	$AnimationPlayer.play("Attack")
	_is_attacking = true

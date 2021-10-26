extends Area2D


const BRAND := "Shortsword"
const NORMAL_PATH := "res://Assets/Swords/Shortsword.png"
const IRON_PATH := "res://Assets/Swords/Iron Shortsword.png"
const GOLD_PATH := "res://Assets/Swords/Golden Shortsword.png"
const NORMAL_DAMAGE := 1
const IRON_DAMAGE := 2
const GOLD_DAMAGE := 3


export var damage := NORMAL_DAMAGE


var type := "Normal"


var _is_attacking := false


func _ready():
	visible = false


func _on_AnimationPlayer_animation_finished(_anim_name):
	_is_attacking = false
	visible = false


func update__type(new_type):
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

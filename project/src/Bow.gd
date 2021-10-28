extends Area2D


const BRAND := "Bow"
const NORMAL_PATH := "res://Assets/Bows/Bow.png"
const NORMAL_DRAWN_PATH := "res://Assets/Bows/Drawn Bow.png"
const IRON_PATH := "res://Assets/Bows/Iron Bow.png"
const IRON_DRAWN_PATH := "res://Assets/Bows/Drawn IronBow.png"
const GOLD_PATH := "res://Assets/Bows/Golden Bow.png"
const GOLD_DRAWN_PATH := "res://Assets/Bows/Drawn Gold Bow.png"
const NORMAL_DAMAGE := 1
const IRON_DAMAGE := 2
const GOLD_DAMAGE := 3
const BOW_ROTATION := -45


export var damage := NORMAL_DAMAGE


var type := "Normal"


var _is_attacking := false


func _ready():
	visible = false
	$Sprite.rotation_degrees = BOW_ROTATION
	$Drawn.rotation_degrees = BOW_ROTATION


func _on_AnimationPlayer_animation_finished(_anim_name):
	var arrow = load("res://src/Arrow.tscn").instance()
	arrow.rotation = rotation
	arrow.damage = damage
	arrow.fire()
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

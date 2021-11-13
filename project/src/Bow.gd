extends Area2D


const NORMAL_PATH := "res://assets/Bows/bow.png"
const NORMAL_DRAWN_PATH := "res://assets/Bows/drawn_bow.png"
const IRON_PATH := "res://assets/Bows/iron_bow.png"
const IRON_DRAWN_PATH := "res://assets/Bows/drawn_iron_bow.png"
const GOLD_PATH := "res://assets/Bows/gold_bow.png"
const GOLD_DRAWN_PATH := "res://assets/Bows/drawn_gold_bow.png"
const NORMAL_DAMAGE := 1
const IRON_DAMAGE := 2
const GOLD_DAMAGE := 3
const BOW_ROTATION := -45


export var damage := NORMAL_DAMAGE
export var weapon_type := "Bow"


var type := "Normal"
var direction := "left"


func _ready():
	$Sprite.rotation_degrees = BOW_ROTATION
	$Drawn.rotation_degrees = BOW_ROTATION


func _on_AnimationPlayer_animation_finished(_anim_name):
	get_parent().spawn_arrow(damage)
	get_parent().remove_weapon()
	queue_free()


func update_type(new_type):
	type = new_type
	if type == "Golden":
		$Sprite.texture = load(GOLD_PATH)
		damage = GOLD_DAMAGE
	elif type == "Iron":
		$Sprite.texture = load(IRON_PATH)
		damage = IRON_DAMAGE


func attack(facing):
	direction = facing
	$AnimationPlayer.play("Attack")


func get_texture():
	return $Sprite.texture

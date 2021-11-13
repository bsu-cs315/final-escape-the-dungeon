extends Area2D


const NORMAL_PATH := "res://assets/Swords/shortsword.png"
const IRON_PATH := "res://assets/Swords/iron_shortsword.png"
const GOLD_PATH := "res://assets/Swords/golden_shortsword.png"
const NORMAL_DAMAGE := 1
const IRON_DAMAGE := 2
const GOLD_DAMAGE := 3


export var damage := NORMAL_DAMAGE
export var weapon_type := "Shortsword"


var type := "Normal"


func _on_AnimationPlayer_animation_finished(_anim_name):
	get_parent().remove_weapon()
	queue_free()


func update_type(new_type):
	type = new_type
	if type == "Golden":
		$CollisionShape2D/Sprite.texture = load(GOLD_PATH)
		damage = GOLD_DAMAGE
	elif type == "Iron":
		$CollisionShape2D/Sprite.texture = load(IRON_PATH)
		damage = IRON_DAMAGE


func attack():
	$AnimationPlayer.play("Attack")


func get_texture():
	return $CollisionShape2D/Sprite.texture

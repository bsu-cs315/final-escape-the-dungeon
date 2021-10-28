extends KinematicBody2D


export var speed := 150
export var health := 5


var primary_weapon = load("res://src/Shortsword.tscn")
var current_weapon
var active := true


var _is_attacking := false
var _is_hurt := false

func _physics_process(delta):
	var direction := Vector2(0,0)
	if Input.is_action_just_pressed("attack") and not _is_attacking:
		attack()
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		
	direction = direction.normalized()
	
	if direction.length() > 0:
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
		
	if direction.x < 0:
		$AnimatedSprite.scale.x = 1
	elif direction.x > 0:
		$AnimatedSprite.scale.x = -1
	
	var _ignored = move_and_collide(direction * speed * delta)
	print(health)


func take_damage(damage):
	health -= damage


func get_current_weapon():
	return primary_weapon


func attack():
	if not current_weapon:
		current_weapon = primary_weapon.instance()
		call_deferred("add_child", current_weapon)
		position_weapon()
		current_weapon.attack()


func position_weapon():
	pass


func remove_weapon():
	current_weapon = null

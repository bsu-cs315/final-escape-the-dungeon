extends KinematicBody2D


const LEFT_ROTATION = -90
const RIGHT_ROTATION = 90
const UP_ROTATION = 0
const DOWN_ROTATION = 180
const CENTER_POINT = Vector2(468,300)


export var speed := 150
export var health := 5


var primary_weapon := load("res://src/Bow.tscn")
var current_weapon
var active := true
var facing := "left"


var _is_hurt := false
var _is_attacking := false


func _physics_process(delta):
	var direction := Vector2(0,0)
	if Input.is_action_just_pressed("attack"):
		attack()
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		
	var mouse_pos = get_viewport().get_mouse_position()
	var x = mouse_pos.x - CENTER_POINT.x
	var y = mouse_pos.y - CENTER_POINT.y
	if x < 0 and abs(x) > abs(y * 1.5):
		facing = "left"
	elif x >= 0 and abs(x) > abs(y * 1.5):
		facing = "right"
	elif y < 0 and abs(y * 1.5) > abs(x):
		facing = "up"
	else:
		facing = "down"
		
	direction = direction.normalized()
	
	if not _is_hurt and not _is_attacking:
		if direction.length() > 0:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")
		
	if direction.x < 0:
		$AnimatedSprite.scale.x = 1
	elif direction.x > 0:
		$AnimatedSprite.scale.x = -1
	
	var _ignored = move_and_collide(direction * speed * delta)


func take_damage(damage):
	if not _is_hurt:
		health -= damage
		_is_hurt = true
		if health <= 0:
			$AnimatedSprite.play("killed")
		else:
			$AnimatedSprite.play("hurt")


func get_current_weapon():
	return current_weapon


func attack():
	if not current_weapon:
		_is_attacking = true
		current_weapon = primary_weapon.instance()
		call_deferred("add_child", current_weapon)
		position_weapon()
		if current_weapon.weapon_type == "Bow":
			current_weapon.attack(facing)
		else:
			current_weapon.attack()
		$AnimatedSprite.play("attack")


func position_weapon():
	if facing == "up":
		current_weapon.position = $AttackUp.position
		current_weapon.position.y -= current_weapon.position_extension
		current_weapon.rotation_degrees += UP_ROTATION
	elif facing == "down":
		current_weapon.position = $AttackDown.position
		current_weapon.position.y += current_weapon.position_extension
		current_weapon.rotation_degrees += DOWN_ROTATION
	elif facing == "left":
		current_weapon.position = $AttackLeft.position
		current_weapon.position.x -= current_weapon.position_extension
		current_weapon.rotation_degrees += LEFT_ROTATION
	elif facing == "right":
		current_weapon.position = $AttackRight.position
		current_weapon.position.x += current_weapon.position_extension
		current_weapon.rotation_degrees += RIGHT_ROTATION


func remove_weapon():
	current_weapon = null
	_is_attacking = false


func _on_AnimatedSprite_animation_finished():
	_is_hurt = false


func spawn_arrow(damage):
	var arrow = load("res://src/Arrow.tscn").instance()
	get_parent().call_deferred("add_child", arrow)
	arrow.damage = damage
	arrow.fire(position, facing)

extends KinematicBody2D


const LEFT_ROTATION := -90
const RIGHT_ROTATION := 90
const UP_ROTATION := 0
const DOWN_ROTATION := 180
const CENTER_POINT := Vector2(468,300)
const WALL_COLLISION := Vector2(0,0)
const DIRECTION_MULT := 1.5


export var speed := 150
export var max_health := 5
export var health := 5
export var key_count := 0


var primary_weapon := load("res://src/Shortsword.tscn")
var secondary_weapon := load("res://src/Bow.tscn")
var current_weapon 
var is_active := true
var is_paused := false
var facing := "left"


var _is_hurt := false
var _is_attacking := false


onready var bar = $HUD/LifeBar


func _ready():
	bar.max_value = max_health
	bar.min_value = 0
	bar.value = health
	$HUD.update_weapons(primary_weapon.instance(), secondary_weapon.instance())


func _physics_process(_delta):
	if Input.is_action_just_pressed("open_inventory"):
		if not is_paused:
			is_paused = true
			get_parent().pause_enemies(true)
			$AnimatedSprite.play("idle")
			$HUD.visible = false
			$Inventory.show_inventory(primary_weapon.instance(), secondary_weapon.instance(), health, key_count)
		else:
			is_paused = false
			get_parent().pause_enemies(false)
			$HUD.visible = true
			$Inventory.hide()
	if is_active and not is_paused:
		var direction := Vector2(0,0)
		if Input.is_action_just_pressed("change_weapon"):
			var switcher = primary_weapon
			primary_weapon = secondary_weapon
			secondary_weapon = switcher
			$HUD.update_weapons(primary_weapon.instance(), secondary_weapon.instance())
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
		if x < 0 and abs(x) > abs(y * DIRECTION_MULT):
			facing = "left"
		elif x >= 0 and abs(x) > abs(y * DIRECTION_MULT):
			facing = "right"
		elif y < 0 and abs(y * DIRECTION_MULT) > abs(x):
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
		
		var _ignored = move_and_slide_with_snap(direction * speed, WALL_COLLISION)


func _on_AnimatedSprite_animation_finished():
	_is_hurt = false


func take_damage(damage):
	if not _is_hurt:
		health -= damage
		bar.value = health
		_is_hurt = true
		if health <= 0:
			$AnimatedSprite.play("killed")
			killed()
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


func spawn_arrow(damage):
	var arrow = load("res://src/Arrow.tscn").instance()
	get_parent().call_deferred("add_child", arrow)
	arrow.damage = damage
	arrow.fire(position, facing)


func killed():
	is_active = false
	$HUD/EndMessage.text = "You Died"
	$HUD/RestartButton.visible = true
	$HUD/EndMessage.visible = true


func win():
	pass

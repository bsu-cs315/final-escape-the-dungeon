extends KinematicBody2D


const ROTATION_OFFSET := 90
const WALL_COLLISION := Vector2(0,0)


export var speed := 150
export var max_health := 5
export var health := 5
export var key_count := 0


var primary_weapon := load("res://src/Shortsword.tscn")
var primary_weapon_rank := "Normal"
var secondary_weapon := load("res://src/Bow.tscn")
var secondary_weapon_rank := "Normal"
var current_weapon 
var is_active := true
var is_paused := false
var angle_facing := 0.0000


var _is_hurt := false
var _is_attacking := false


onready var bar = $HUD/LifeBar


func _ready():
	bar.max_value = max_health
	bar.min_value = 0
	bar.value = health
	$HUD.update_weapons(initialize_weapon(primary_weapon, primary_weapon_rank), initialize_weapon(secondary_weapon, secondary_weapon_rank))


func _physics_process(_delta):
	if Input.is_action_just_pressed("open_inventory"):
		if not is_paused:
			is_paused = true
			get_parent().pause_enemies(true)
			$AnimatedSprite.play("idle")
			$HUD.visible = false
			$Inventory.show_inventory(initialize_weapon(primary_weapon, primary_weapon_rank), initialize_weapon(secondary_weapon, secondary_weapon_rank), health, key_count)
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
			switcher = primary_weapon_rank
			primary_weapon_rank = secondary_weapon_rank
			secondary_weapon_rank = switcher
			$HUD.update_weapons(initialize_weapon(primary_weapon, primary_weapon_rank), initialize_weapon(secondary_weapon, secondary_weapon_rank))
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
		current_weapon = initialize_weapon(primary_weapon, primary_weapon_rank)
		call_deferred("add_child", current_weapon)
		position_weapon()
		current_weapon.attack()
		$AnimatedSprite.play("attack")


func position_weapon():
	angle_facing = rad2deg(get_angle_to(get_global_mouse_position())) + ROTATION_OFFSET
	current_weapon.position = $Center.position
	current_weapon.rotation_degrees += angle_facing


func remove_weapon():
	current_weapon = null
	_is_attacking = false


func spawn_arrow(damage):
	var arrow = load("res://src/Arrow.tscn").instance()
	get_parent().call_deferred("add_child", arrow)
	arrow.damage = damage
	arrow.fire(position, angle_facing)


func killed():
	is_active = false
	$HUD/EndMessage.text = "You Died"
	$HUD/RestartButton.visible = true
	$HUD/EndMessage.visible = true


func win():
	pass


func initialize_weapon(weapon_type, rank):
	var instance = weapon_type.instance()
	instance.update_type(rank)
	return instance

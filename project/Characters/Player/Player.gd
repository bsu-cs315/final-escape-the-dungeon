extends KinematicBody2D


const ROTATION_OFFSET := 90
const WALL_COLLISION := Vector2(0,0)
const POTION_HEALTH := 2.00


export var speed := 500
export var max_health := 5.00
export var health := 5.00
export var has_key := false


var primary_weapon := load("res://Characters/Player/Shortsword.tscn")
var primary_weapon_rank := "Normal"
var secondary_weapon := load("res://Characters/Player/Bow.tscn")
var secondary_weapon_rank := "Normal"
var current_weapon 
var is_active := true
var is_paused := false
var is_clicking_button := false
var angle_facing := 0.0000


var _is_hurt := false
var _is_attacking := false


onready var bar = $HUD/LifeBar


func _ready():
	bar.max_value = max_health
	bar.min_value = 0
	bar.value = health
	$HUD.update_weapons(initialize_weapon(primary_weapon, primary_weapon_rank), initialize_weapon(secondary_weapon, secondary_weapon_rank), false)


func _physics_process(_delta):
	if Input.is_action_just_pressed("open_inventory"):
		if not is_paused:
			pause()
		else:
			unpause()
	if is_active and not is_paused:
		var direction := Vector2(0,0)
		if Input.is_action_just_pressed("change_weapon"):
			switch_weapon()
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


func _on_InventoryButton_toggled(button_pressed):
	if button_pressed:
		if current_weapon:
			current_weapon.queue_free()
			remove_weapon()
		pause()
	else:
		unpause()
		if current_weapon:
			current_weapon.queue_free()
			remove_weapon()

func _on_WeaponButton_toggled(button_pressed):
	if button_pressed:
		if current_weapon:
			current_weapon.queue_free()
			remove_weapon()
		switch_weapon()
	else:
		switch_weapon()
		if current_weapon:
			current_weapon.queue_free()
			remove_weapon()


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
	$Camera2D.screen_shake(.5)


func get_current_weapon():
	return current_weapon
	
func get_key_count():
	return has_key
	
func use_key():
	has_key = false
	$HUD.update_key_count(has_key)
	current_weapon.queue_free()
	remove_weapon()


func attack():
	if not current_weapon and not is_clicking_button:
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
	var arrow = load("res://Characters/Player/Arrow.tscn").instance()
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


func pause():
	is_paused = true
	get_parent().pause_enemies(true)
	$AnimatedSprite.play("idle")
	$HUD.visible = false
	$Inventory.show_inventory(primary_weapon.instance(), secondary_weapon.instance(), health)


func unpause():
	is_paused = false
	get_parent().pause_enemies(false)
	$HUD.visible = true
	$Inventory.hide_inventory()


func initialize_weapon(weapon_type, rank):
	var instance = weapon_type.instance()
	instance.update_type(rank)
	return instance


func collect_item(item_type, item_rank):
	if item_type == "Potion":
		health = clamp(health + POTION_HEALTH, 0.00, max_health)
		bar.value = health
		spawn_particles("res://Characters/Player/ArrowParticles.tscn")
	elif item_type == "Key":
		has_key = true
		$HUD.update_key_count(has_key)
	elif item_type == "Hat":
		$AnimatedSprite/Hat.visible = true
	elif item_type == "Bow":
		drop_item()
		primary_weapon = load("res://Characters/Player/Bow.tscn")
		primary_weapon_rank = item_rank
		$HUD.update_weapons(initialize_weapon(primary_weapon, primary_weapon_rank), initialize_weapon(secondary_weapon, secondary_weapon_rank), true)
	elif item_type == "Shortsword":
		drop_item()
		primary_weapon = load("res://Characters/Player/Shortsword.tscn")
		primary_weapon_rank = item_rank
		$HUD.update_weapons(initialize_weapon(primary_weapon, primary_weapon_rank), initialize_weapon(secondary_weapon, secondary_weapon_rank), true)
	elif item_type == "Longsword":
		drop_item()
		primary_weapon = load("res://Characters/Player/Longsword.tscn")
		primary_weapon_rank = item_rank
		$HUD.update_weapons(initialize_weapon(primary_weapon, primary_weapon_rank), initialize_weapon(secondary_weapon, secondary_weapon_rank), true)


func drop_item():
	var item = load("res://Levels/Main/Item.tscn").instance()
	item.set_item(primary_weapon.instance().weapon_type, primary_weapon_rank)
	item.position = position
	current_weapon.queue_free()
	remove_weapon()
	get_parent().call_deferred("add_child", item)


func switch_weapon():
	var switcher = primary_weapon
	primary_weapon = secondary_weapon
	secondary_weapon = switcher
	switcher = primary_weapon_rank
	primary_weapon_rank = secondary_weapon_rank
	secondary_weapon_rank = switcher
	$HUD.update_weapons(initialize_weapon(primary_weapon, primary_weapon_rank), initialize_weapon(secondary_weapon, secondary_weapon_rank), true)


func spawn_particles(par_tex):
	var particles = load("res://Characters/Player/ArrowParticles.tscn").instance()
	particles.texture = load(par_tex)
	particles.position = position
	particles.emitting = true
	particles.z_index = 100
	get_parent().call_deferred("add_child", particles)

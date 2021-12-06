extends KinematicBody2D


const SPEED := 3200
const DISTANCE := Vector2(1000,1000)
const BOSS_ATTACK_DAMAGE := 2
const BOSS_VELOCITY_BUFFER := 60


export var health := 15


var velocity := Vector2()
var previous_velocity := Vector2.ZERO


var _is_hurt := false
var _is_attacking := false
var _is_paused := false


onready var player := get_node("../Player")


func _process(_delta):
	if _is_hurt or _is_attacking or _is_paused:
		velocity = Vector2.ZERO
	elif player.position.x <= position.x + DISTANCE.x and player.position.y <= position.y + DISTANCE.y:
		previous_velocity = velocity
		if player.position.x > position.x:
			velocity.x += SPEED
		if player.position.x < position.x:
			velocity.x -= SPEED
		if player.position.y > position.y:
			velocity.y += SPEED
		if player.position.y < position.y:
			velocity.y -= SPEED
		$AnimatedSprite.play("walk")
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite.play("default")
	if previous_velocity.x > BOSS_VELOCITY_BUFFER or previous_velocity.x < -BOSS_VELOCITY_BUFFER:
		if velocity.x < 0:
			$AnimatedSprite.scale.x = 1
		elif velocity.x > 0:
			$AnimatedSprite.scale.x = -1


func _physics_process(delta):
	velocity = move_and_slide(velocity * delta)


func _on_Area2D_area_entered(area):
	if area == player.get_current_weapon():
		take_damage(area.damage)


func _on_AnimatedSprite_animation_finished():
	if health <= 0:
		queue_free()
	else:
		_is_hurt = false
		_is_attacking = false


func _on_Area2D_body_entered(body):
	if body == player:
		attack()


func attack():
	if not _is_attacking and not _is_hurt:
		$AnimatedSprite.play("attack")
		player.take_damage(BOSS_ATTACK_DAMAGE)
		_is_attacking = true


func take_damage(damage):
	if not _is_hurt:
		health -= damage
		if health <= 0:
			$AnimatedSprite.play("killed")
			$sound.stream = load("res://Characters/Enemies/deathMonsterconverted.wav")
			$sound.play()
			var hat = load("res://Levels/Main/Items/Item.tscn").instance()
			hat.set_item("Hat", "null")
			hat.position = position
			get_parent().call_deferred("add_child", hat)
		else:
			$sound.stream = load("res://Characters/Enemies/hurtMonstertrimmed.wav")
			$sound.play()
			if health <= 5:
				$AnimatedSprite.play("hurt 2") 
			else:
				$AnimatedSprite.play("hurt")
			if damage == 0:
				var particles = load("res://Characters/Player/ArrowParticles.tscn").instance()
				particles.texture = load("res://Characters/Enemies//stun_particle.png")
				particles.position = position
				particles.emitting = true
				get_parent().call_deferred("add_child", particles)
		_is_hurt = true


func pause(value):
	_is_paused = value

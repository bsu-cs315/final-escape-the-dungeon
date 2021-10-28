extends KinematicBody2D


const SPEED := 1000
const DISTANCE := Vector2(500,500)


export var health := 1


var velocity := Vector2()


var _is_hurt := false


onready var player := get_node("../Player")


func _process(delta):
	if _is_hurt:
		velocity = Vector2.ZERO
	elif player.position.x <= DISTANCE.x and player.position.y <= DISTANCE.y:
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
	if velocity.x < 0:
		$AnimatedSprite.scale.x = 1
	elif velocity.x > 0:
		$AnimatedSprite.scale.x = -1


func _physics_process(delta):
	velocity = move_and_slide(velocity * delta)


func _on_Area2D_area_entered(area):
	#Check if player's weapon OR arrow
	#If so, find damage of attack
	#Take appropriate health with take_damage(), kill if necessary.
	pass # Replace with function body.


func attack():
	pass


func take_damage(damage):
	health -= damage
	if health <= 0:
		$AnimatedSprite.play("killed")
	else:
		$AnimatedSprite.play("hurt")
		_is_hurt = true


func _on_AnimatedSprite_animation_finished():
	if health <= 0:
		queue_free()
	else:
		_is_hurt = false

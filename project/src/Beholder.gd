extends KinematicBody2D


export var health := 1




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


func _on_AnimatedSprite_animation_finished():
	if health <= 0:
		queue_free()

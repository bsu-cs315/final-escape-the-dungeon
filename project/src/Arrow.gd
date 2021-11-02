extends Area2D


const TIMER_WAIT := 3
const UP_ROTATION := 0
const DOWN_ROTATION := 180
const LEFT_ROTATION := -90
const RIGHT_ROTATION := 90
const SPEED := 500


export var damage := 1
export var weapon_type := "Arrow"


var _launcher := "Player"
var facing = "left"
var pos := Vector2.ZERO
var x := 0
var y := 0


func _process(delta):
	if facing == "down":
		y = SPEED
	elif facing == "right":
		x = SPEED
	elif facing == "up":
		y = -SPEED
	elif facing == "left":
		x = -SPEED
	pos.x += x * delta
	pos.y += y * delta
	position = pos


func set_launcher(entity):
	_launcher = entity


func get_launcher():
	return _launcher


func fire(bow_pos, direction):
	position = bow_pos
	pos = bow_pos
	facing = direction
	if direction == "down":
		rotation_degrees += DOWN_ROTATION
	elif direction == "right":
		rotation_degrees += RIGHT_ROTATION
	elif direction == "up":
		rotation_degrees += UP_ROTATION
	elif direction == "left":
		rotation_degrees += LEFT_ROTATION


func _on_Timer_timeout():
	queue_free()


func _on_Arrow_body_entered(body):
	if body != get_parent().get_node("Player"):
		if not body is TileMap:
			body.take_damage(damage)
		queue_free()

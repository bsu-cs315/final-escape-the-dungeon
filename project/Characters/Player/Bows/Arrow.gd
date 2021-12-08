extends Area2D


const TIMER_WAIT := 3
const UP_ROTATION := 0
const DOWN_ROTATION := 180
const LEFT_ROTATION := -90
const RIGHT_ROTATION := 90
const SPEED := 500.0000
const ANGLE_ADDITION := 90.0000


export var damage := 1
export var weapon_type := "Arrow"


var facing := 0
var pos := Vector2.ZERO
var x := 0.0000
var y := 0.0000


var _launcher := "Player"


func _process(delta):
	y = sin(deg2rad(facing + ANGLE_ADDITION)) * SPEED * -1.0000
	x = cos(deg2rad(facing + ANGLE_ADDITION)) * SPEED * -1.0000
	pos.x += x * delta
	pos.y += y * delta
	position = pos


func set_launcher(entity):
	_launcher = entity


func get_launcher():
	return _launcher


func spawn_particles():
	var particles = load("res://Characters/Player/Bows/ArrowParticles.tscn").instance()
	get_parent().call_deferred("add_child", particles)
	particles.emitting = true
	particles.position = position


func fire(bow_pos, direction):
	position = bow_pos
	pos = bow_pos
	facing = direction
	rotation_degrees = direction


func _on_Timer_timeout():
	queue_free()


func _on_Arrow_body_entered(body):
	if body.name != 'Player':
		if not body is TileMap and body.name != "GateBody":
			body.take_damage(damage)
		spawn_particles()
		queue_free()

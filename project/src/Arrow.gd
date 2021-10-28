extends Area2D


export var damage := 1


var _launcher := "Player"


func set_launcher(entity):
	_launcher = entity


func get_launcher():
	return _launcher


func fire():
	#Fire the arrow the direction the player/entity is facing
	pass


func _on_Arrow_collision(_area):
	queue_free()

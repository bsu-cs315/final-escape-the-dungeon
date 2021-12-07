extends Sprite


signal open


onready var player := get_node("../Player")


func _on_Area2D_area_entered(area):
	if area == player.get_current_weapon():
		emit_signal("open", self)

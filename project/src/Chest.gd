extends Sprite

signal open

onready var player := get_node("../Player")

func _on_Area2D_area_entered(area):
	if area == player.get_current_weapon():
		if player.get_key_count() > 0:
			player.use_key()
			emit_signal("open", self)
		else:
			print("No Keys")

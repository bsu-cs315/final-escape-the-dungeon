extends Node2D


func _process(_delta):
	var no_enemies = get_tree().get_nodes_in_group("Enemies").empty()
	if no_enemies:
		$Player.active = false
		$Player/HUD/EndMessage.text = "You Win"
		$Player/HUD/RestartButton.visible = true
		$Player/HUD/EndMessage.visible = true


func pause_enemies(value):
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.pause(value)


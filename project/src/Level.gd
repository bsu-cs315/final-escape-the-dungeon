extends Node2D

func _process(_delta):
	var noEnemies = get_tree().get_nodes_in_group("Enemies").empty()
	if noEnemies:
		$Player.active = false
		$Player/HUD/EndMessage.text = "You Win"
		$Player/HUD/RestartButton.visible = true
		$Player/HUD/EndMessage.visible = true

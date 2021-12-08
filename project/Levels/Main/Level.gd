extends Node2D


var does_boss_exist := true
var player_position := Vector2.ZERO
var is_boss_ambient_playing := false

func _ready():
	$Item.set_item("Potion", "null")


func _process(_delta):
	player_position = $Player.position


func pause_enemies(value):
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.pause(value)


func get_player_position():
	return player_position


func play_boss_ambient():
	if not is_boss_ambient_playing:
		is_boss_ambient_playing = true
		$Boss/BossAmbient.play()


func _on_Chest_open(chest):
	var position = chest.position
	var new_item: Item = load("res://Levels/Main/Items/Item.tscn").instance()
	new_item.set_item("Potion", "null")
	new_item.position = position
	call_deferred("remove_child", chest)
	call_deferred("add_child", new_item)


func _on_Dungeon_body_exited(body):
	if body.name == 'Player':
		$Player.is_active = false
		$Player/HUD/EndMessage.text = "You Win"
		$Player/HUD/RestartButton.visible = true
		$Player/HUD/EndMessage.visible = true


func _on_IntroPopup_popup_hide():
	get_tree().paused = false;


func _on_GateArea_body_entered(body):
	if body == $Player:
		if $Player.has_key:
			$Gate.queue_free()
			$Player.has_key = false


func _on_BossArea_body_entered(body):
	if body.name == 'Player' and does_boss_exist:
		$BossWall.visible = true;
		$BossWall.set_collision_mask(1)
		$BossWall.set_collision_layer(1)


func _on_BossArea_body_exited(body):
	if body.name == 'Boss':
		$BossWall.queue_free()
		does_boss_exist = false


func _on_BossAmbient_finished():
	$Boss/BossAmbient.play()

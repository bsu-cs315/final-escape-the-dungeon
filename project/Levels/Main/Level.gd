extends Node2D


var does_boss_exist := true


func _ready():
	$Item.set_item("Potion", "null")

func _process(_delta):
	var no_enemies = get_tree().get_nodes_in_group("Enemies").empty()
	if no_enemies:
		$Gate.visible  = false
		$Gate/StaticBody2D/CollisionShape2D.disabled = true
		$Player/HUD/DoorLabel.show()


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


func pause_enemies(value):
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.pause(value)


func _on_BossArea_body_entered(body):
	if body.name == 'Player' and does_boss_exist:
		$BossWall.visible = true;
		$BossWall.set_collision_mask(1)
		$BossWall.set_collision_layer(1)


func _on_BossArea_body_exited(body):
	if body.name == 'Boss':
		$BossWall.queue_free()
		does_boss_exist = false
		
		

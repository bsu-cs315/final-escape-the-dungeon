class_name Item
extends Sprite


var potion := load("res://Levels/Main/Items/potion_full.png")
var key := load("res://Levels/Main/Items/key.png")
var shortsword := load("res://Characters/Player/Swords/shortsword.png")
var iron_shortsword := load("res://Characters/Player/Swords/iron_shortsword.png")
var gold_shortsword := load("res://Characters/Player/Swords/golden_shortsword.png")
var longsword := load("res://Characters/Player/Swords/longsword.png")
var iron_longsword := load("res://Characters/Player/Swords/iron_longsword.png")
var gold_longsword := load("res://Characters/Player/Swords/golden_longsword.png")
var bow := load("res://Characters/Player/Bows/bow.png")
var iron_bow := load("res://Characters/Player/Bows/iron_bow.png")
var gold_bow := load("res://Characters/Player/Bows/gold_bow.png")
var hat := load("res://Levels/Main/Items/hat.png")
var type := "Empty Potion"
var rank := "null"


export var area_type := "item"


onready var player := get_node("../Player")


func _on_Area2D_body_entered(body):
	if body == player:
		collect()


func set_item(new_type, new_rank):
	type = new_type
	rank = new_rank
	if type == "Potion":
		texture = potion
	elif type == "Hat":
		texture = hat
	elif type == "Key":
		texture = key
	elif type == "Bow":
		if rank == "Normal":
			texture = bow
		elif rank == "Iron":
			texture = iron_bow
		else:
			texture = gold_bow
	elif type == "Shortsword":
		if rank == "Normal":
			texture = shortsword
		elif rank == "Iron":
			texture = iron_shortsword
		else:
			texture = gold_shortsword
	elif type == "Longsword":
		if rank == "Normal":
			texture = longsword
		elif rank == "Iron":
			texture = iron_longsword
		else:
			texture = gold_longsword


func collect():
	player.collect_item(type, rank)
	queue_free()

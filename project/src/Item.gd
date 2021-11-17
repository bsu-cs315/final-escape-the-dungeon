extends Sprite
class_name Item


var potion := load("res://assets/Items/potion_full.png")
var key := load("res://assets/Items/key.png")
var shortsword := load("res://assets/Swords/shortsword.png")
var iron_shortsword := load("res://assets/Swords/iron_shortsword.png")
var gold_shortsword := load("res://assets/Swords/golden_shortsword.png")
var longsword := load("res://assets/Swords/longsword.png")
var iron_longsword := load("res://assets/Swords/iron_longsword.png")
var gold_longsword := load("res://assets/Swords/golden_longsword.png")
var bow := load("res://assets/Bows/bow.png")
var iron_bow := load("res://assets/Bows/iron_bow.png")
var gold_bow := load("res://assets/Bows/gold_bow.png")
var type := "Empty Potion"
var rank := "null"


export var area_type := "item"

onready var player := get_node("../Player")


func set_item(new_type, new_rank):
	type = new_type
	rank = new_rank
	if type == "Potion":
		texture = potion
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


func _on_Area2D_area_entered(area):
	if area == player.get_current_weapon():
		collect()


func collect():
	player.collect_item(type, rank)
	queue_free()

extends Camera2D


const DECAY := 0.8
const MAX_OFFSET := Vector2(100, 75)
const MAX_ROLL := 0.1
const TRAUMA_POWER := 2


var trauma := 0.0
var noise_y := 0


onready var noise := OpenSimplexNoise.new()


func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2


func _process(delta):
	if trauma:
		trauma = max(trauma - DECAY * delta, 0)
		shake()


func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)


func screen_shake(value):
	trauma += value


func shake():
	var amount = pow(trauma, TRAUMA_POWER)
	noise_y += 1
	rotation = MAX_ROLL * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = MAX_OFFSET.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = MAX_OFFSET.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)

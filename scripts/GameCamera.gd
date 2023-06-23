class_name CustomCamera
extends Camera2D

@export var shake_noise: FastNoiseLite
@export var initial_position: Vector2

var x_noise_sample_vector = Vector2.RIGHT
var y_noise_sample_vector = Vector2.DOWN
var x_noise_sample_position = Vector2.ZERO
var y_noise_sample_position = Vector2.ZERO
var noise_sample_travel_rate = 50
var max_shake_offset = 10
var current_shake_percentage = 0
var shake_decay = 3

func _process(delta):
	global_position = initial_position
	if current_shake_percentage > 0:
		x_noise_sample_position += x_noise_sample_vector * noise_sample_travel_rate * delta
		y_noise_sample_position += y_noise_sample_vector * noise_sample_travel_rate * delta
		var x_sample = shake_noise.get_noise_2d(x_noise_sample_position.x, x_noise_sample_position.y)
		var y_sample = shake_noise.get_noise_2d(y_noise_sample_position.x, y_noise_sample_position.y)
		
		var calculated_offset = Vector2(x_sample, y_sample) * max_shake_offset * pow(current_shake_percentage, 2)
		offset = calculated_offset
		current_shake_percentage = clamp(current_shake_percentage - shake_decay, 0, 1)

func apply_shake(percentage):
	current_shake_percentage = clamp(current_shake_percentage + percentage, 0, 1)

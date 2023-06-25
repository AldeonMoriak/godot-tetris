extends Node

@export var number_to_play: int = 3
@export var enable_pitch_randomization = true
@export var min_pitch_scale := 0.9
@export var max_pitch_scale := 1.1

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

func play():
	var valid_nodes: Array[AudioStreamPlayer] = []
	for audio_stream_player in get_children():
		if audio_stream_player is AudioStreamPlayer:
			if not audio_stream_player.playing:
				valid_nodes.append(audio_stream_player)
	for i in number_to_play:
		if valid_nodes.size() == 0:
			break
		var idx = rng.randi_range(0, valid_nodes.size() - 1)
		if enable_pitch_randomization:
			valid_nodes[idx].pitch_scale = rng.randf_range(min_pitch_scale, max_pitch_scale)
		valid_nodes[idx].play()
		valid_nodes.remove_at(idx)

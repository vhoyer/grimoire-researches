extends Node
class_name AudioStreamPlayerPool

@export var pool_size:= 20
@export var streams: Array[AudioStream]
@export var bus: StringName = &"Master"
@export_range(0.0, 1.0) var pitch_variation:= 0.12
@export var timeout:= 0.0

var is_timed_out = false

func play_immediately() -> AudioStreamPlayer:
	if get_child_count() > pool_size:
		remove_child(get_child(0))
	
	if not is_timed_out and timeout > 0:
		is_timed_out = true
		get_tree().create_timer(timeout).timeout.connect(func():
			is_timed_out = false
			)
	elif is_timed_out:
		return
	
	var player = AudioStreamPlayer.new()
	player.stream = streams.pick_random()
	player.autoplay = true
	player.bus = bus
	player.pitch_scale += randf_range(- pitch_variation, pitch_variation)
	
	player.finished.connect(remove_from_pool.bind(player))
	add_child(player)
	return player

func remove_from_pool(player: AudioStreamPlayer) -> void:
	remove_child(player)
	pass

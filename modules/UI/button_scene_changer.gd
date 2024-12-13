class_name ButtonSceneChanger extends Button

@export var scene: PackedScene

func _ready() -> void:
	connect("button_up", _button_up)

func _button_up() -> void:
	get_tree().change_scene_to_packed(scene)

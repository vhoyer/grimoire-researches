class_name ButtonSceneChanger extends Button

@export var scene: PackedScene

var has_scene_manager: bool:
	get():
		return get_tree().root.get_child(0) is SceneManager

func _ready() -> void:
	connect("button_up", _button_up)

func _button_up() -> void:
	if has_scene_manager:
		var mngr = SceneManager.singleton
		mngr.change_scene_to_packed(scene)
	else:
		get_tree().change_scene_to_packed(scene)

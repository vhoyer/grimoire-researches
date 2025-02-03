class_name ButtonSceneChanger extends Button

@export var scene: PackedScene

## If go_back is set to true, scene variable will be ignored
@export var go_back: bool = false
@export var go_back_by: int = -1

@export var payloads: Dictionary

var has_scene_manager: bool:
	get():
		return get_tree().root.get_child(0) is SceneManager

func _ready() -> void:
	connect("button_up", _button_up)

func _button_up() -> void:
	if has_scene_manager:
		var mngr = SceneManager.singleton
		if go_back:
			SceneManager.go_back(go_back_by)
		else:
			for key in payloads.keys():
				SceneManager.set_payload(key, payloads[key])
			mngr.change_scene_to_packed(scene)
	else:
		var err = get_tree().change_scene_to_packed(scene)
		if err != OK: print(error_string(err))

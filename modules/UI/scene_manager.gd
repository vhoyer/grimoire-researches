extends Node
class_name SceneManager
## This Node should be the root node of the main scene project

@export var main_scene: PackedScene;

static var singleton: SceneManager:
	get():
		if !singleton:
			assert(false, "Error: singleton not loaded")
			return
		return singleton

static func get_payload(key):
	var pay = SceneManager.singleton.payloads
	var value = pay[key]
	pay.erase(key)
	return value
static func set_payload(key, value):
	SceneManager.singleton.payloads[key] = value

var payloads: Dictionary = {};

func _ready() -> void:
	singleton = self
	
	var instance = main_scene.instantiate()
	#instance.set()
	self.add_child(instance)


func change_scene_to_packed(scene: PackedScene) -> void:
	self.remove_child(self.get_child(0))
	var instance = scene.instantiate()
	self.add_child(instance)
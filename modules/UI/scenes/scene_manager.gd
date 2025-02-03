extends Node
class_name SceneManager
## This Node should be the root node of the main scene project

const CHILD_SCHENE_NAME = "scene"

@export var main_scene: PackedScene

static var singleton: SceneManager:
	get():
		if !singleton:
			assert(false, "Error: singleton not loaded")
			return
		return singleton

static func get_payload(key, default = null):
	var pay = SceneManager.singleton.payloads
	if !pay.has(key): return default
	var value = pay[key]
	pay.erase(key)
	return value
static func set_payload(key, value):
	SceneManager.singleton.payloads[key] = value
	SceneManager.singleton.payload_updated.emit(key)

static func go_back(index: int = -1):
	SceneManager.singleton.current_cursor += index
	
	var cur_index = SceneManager.singleton.current_cursor
	var cur_history_entry = SceneManager.singleton.history[cur_index]
	SceneManager.singleton.payloads = cur_history_entry.payloads.duplicate(true)
	SceneManager.singleton.update_current_view()

static func get_current_stage() -> Node:
	return SceneManager.singleton.current_instance

static func reload_current_stage() -> void:
	go_back(0)

signal payload_updated(key: Variant)
signal stage_changed

var payloads: Dictionary = {}

class HistoryEntry:
	var scene: PackedScene
	var payloads: Dictionary
	func _init(lscene, lpayloads):
		self.scene = lscene
		self.payloads = lpayloads

var history: Array[HistoryEntry] = []

func append_to_history(packed_scene: PackedScene):
	history.append(HistoryEntry.new(packed_scene, payloads.duplicate(true)))

var last_scene: PackedScene:
	get():
		return history.back().scene

var current_cursor: int = 0

var current_instance: Node

func _init() -> void:
	singleton = self

func _ready() -> void:
	append_to_history(main_scene)
	current_instance = main_scene.instantiate()
	current_instance.name = CHILD_SCHENE_NAME
	self.add_child(current_instance)


func change_scene_to_packed(scene: PackedScene) -> void:
	if current_cursor != history.size() - 1:
		history.resize(current_cursor + 1)
	
	append_to_history(scene)
	current_cursor += 1
	update_current_view()

func update_current_view() -> void:
	var scene = history[current_cursor].scene
	self.remove_child(self.find_child(CHILD_SCHENE_NAME+"*", false, false))
	current_instance = scene.instantiate()
	current_instance.name = CHILD_SCHENE_NAME
	self.add_child(current_instance)
	stage_changed.emit()

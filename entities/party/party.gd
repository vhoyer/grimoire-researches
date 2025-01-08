extends Resource
class_name Party

signal updated
const SIZE = 3

@export var members: Array[Mage] = []:
	set(value):
		for mage in members:
			if mage.updated.is_connected(updated.emit):
				mage.updated.disconnect(updated.emit)
		members = value
		for mage in members:
			mage.updated.connect(updated.emit)
		updated.emit()

var hash: String:
	get():
		var prehash = PackedStringArray()
		for mage in members:
			prehash.append_array([
				mage.name,
				mage.grimoire.hash,
			])
		return JSON.stringify(prehash)


func _init(members: Array[Mage] = []):
	self.members = members


func load_hash(hash: String) -> void:
	var raw = JSON.parse_string(hash)
	if raw == null:
		self.hash = self.hash
		return
	var posthash = raw as PackedStringArray
	var new_members = [] as Array[Mage]
	for i in SIZE:
		var chunk = posthash.slice(i * 2, i * 2 + 2)
		var name = chunk[0]
		var grimoire_hash = chunk[1]
		var mage = Mage.new(name, Grimoire.new(grimoire_hash))
		new_members.push_back(mage)
	members = new_members


func reset_combat_state() -> void:
	for mage in members:
		mage.reset_combat_state()

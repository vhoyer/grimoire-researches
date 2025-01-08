extends Resource
class_name Party

const SIZE = 3

@export var members: Array[Mage] = []

var hash: String:
	get():
		var prehash = PackedStringArray()
		for mage in members:
			prehash.append_array([
				mage.name,
				mage.grimoire.hash,
			])
		return Marshalls.variant_to_base64(prehash, true)


func _init(members: Array[Mage] = []):
	self.members = members


func load_hash(hash: String) -> void:
	var posthash = Marshalls.base64_to_variant(hash, true) as PackedStringArray
	members.clear()
	for i in SIZE:
		var chunk = posthash.slice(i, i * 2 + 2)
		var name = chunk[0]
		var grimoire_hash = chunk[1]
		var mage = Mage.new(name, Grimoire.new(grimoire_hash))
		members.push_back(mage)
		

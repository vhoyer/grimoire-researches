extends Resource
class_name ChanceManager

var rng = RandomNumberGenerator.new()
var multiplier = 1

func roll(chance: float) -> bool:
	var result = chance * multiplier >= rng.randf()
	if !result:
		multiplier += 1
	else:
		multiplier = 1
	return result

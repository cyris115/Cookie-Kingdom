extends Area2D

var effects = ["hp", "stam"]

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var roll = randf()
		if roll < 0.5:
			var effect = effects[randi_range(0,len(effects)-1)]
			if effect == "hp" and body.max_hp != 20:
				#Currently, if max_hp can not be reduced further, then nothing happens
				body.max_hp -= 20
				if body.hp > body.max_hp:
					body.take_damage(body.hp - body.max_hp)
				print("Max HP reduced")
			elif effect == "stam" and body.max_stam != 20:
				body.max_stam -= 20
				if body.stam > body.max_stam:
					body.reduce_stam(body.max_stam)
				print("Max stamina reduced")
			else:
				print("Krunch remains safe this time")
		else:
			print("Krunch remains safe this time")
		queue_free()

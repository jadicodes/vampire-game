extends Area2D

var bite_victims : Array[Villager]


func set_bite_victim(new_victim):
	bite_victims = new_victim


func get_bite_victims():
	return bite_victims


func _on_body_entered(body: Node2D) -> void:
	bite_victims.append(body)


func _on_body_exited(body: Node2D) -> void:
	bite_victims.erase(body)
	print(bite_victims)

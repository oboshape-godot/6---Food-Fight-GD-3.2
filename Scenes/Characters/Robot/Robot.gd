extends "res://Scenes/Characters/Character.gd"


func _physics_process(_delta):
	if $RayCast.is_colliding():
		try_to_fire()

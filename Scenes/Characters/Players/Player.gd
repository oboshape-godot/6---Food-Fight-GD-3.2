extends "res://Scenes/Characters/Character.gd"

const SPEED = 10
const UP = Vector3(0,1,0)
var motion = Vector3()

var movement_state = 0 # idle is 0, run is 1

export var mouse_sensitivity = 1200

const MIN_BLEND_SPEED = 0.125 # min movement threshold before starting blend anims
const BLEND_TO_RUN = 0.075
const BLEND_TO_IDLE = 0.075


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(_delta):
	move()
	animate()


func _input(event):
	if event is InputEventMouseMotion:
		rotation = h_camera_rotation(-event.relative.x/mouse_sensitivity)
		$Camera.rotation = v_camera_rotation(-event.relative.y/mouse_sensitivity)
	
	if Input.is_action_just_pressed("fire"):
		try_to_fire()


func move():
	var movement_dir = get_2d_movement_dir()
	var direction = Vector3.ZERO
	var camera_xform = $Camera.global_transform
	
	direction -= camera_xform.basis.z.normalized() * movement_dir.x
	direction += camera_xform.basis.x.normalized() * movement_dir.y
	direction.y = 0
	
	motion = direction
	
	var _err = move_and_slide(motion * SPEED, UP) # not using the return value, just to remove warning
	


func get_2d_movement_dir():
	var x = Input.get_action_strength("forward") - Input.get_action_strength("back")
	var y = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	var movement_direction = Vector2(x, y)
	
	if not movement_direction == Vector2.ZERO:
		face_forward(x, y)
	
	return movement_direction.normalized()
	


func face_forward(x, y):
	$Armature.rotation.y = atan2(x,y)- (PI/2)


func animate():
	if (motion * SPEED).length() > MIN_BLEND_SPEED:
		movement_state += BLEND_TO_RUN
	else:
		movement_state -= BLEND_TO_IDLE
	
	movement_state = clamp(movement_state, 0, 1)
	var animation = $Armature/AnimationTree
	animation["parameters/Blend2/blend_amount"] = movement_state


func h_camera_rotation(camera_rotation):
	return rotation + Vector3(0,camera_rotation, 0)
	
func v_camera_rotation(camera_rotation):
	var rot = $Camera.rotation + Vector3(camera_rotation, 0, 0)
	rot.x = clamp(rot.x, PI/-8, PI/8)
	return rot




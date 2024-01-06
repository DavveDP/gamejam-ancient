extends Node2D

var throwSpeedBar : ProgressBar
var aimArrow : Node
var player : Node
var characther : Node

@export var charge_time: float = 1.5
@export var spear_spawn_offset: Vector2 = Vector2(0, -270)
@export var spawn_distance_from_center : float = 600
@export var max_throw_speed: float = 1000.0
@export var rotation_speed = 1.5

var _charge = 0 #Float between 0 and 1
var _aim_angle = 0
var _rotation_direction = 0
var _spawn_direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	characther = get_parent()
	player = characther.get_parent()
	throwSpeedBar = $ThrowSpeedBar
	aimArrow = $AimArrow

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	_rotation_direction = Input.get_axis("Aim Left", "Aim Right")
	_aim_angle += _rotation_direction * rotation_speed * delta
	_aim_angle = clamp(_aim_angle, -PI/4, PI/4)
	update_arrow()

	if Input.is_action_pressed("charge_spear"):
		_charge += delta/charge_time
		update_bar()
		
	if Input.is_action_just_released("charge_spear"):
		throw_spear()
		reset_charge()
		update_bar()

func update_arrow():
	aimArrow.rotation = _aim_angle

func update_bar():
	throwSpeedBar.value = _charge*throwSpeedBar.max_value
	
func reset_charge():
	_charge = 0.0

func throw_spear():
	var spear_scene = preload("res://Scenes/spear.tscn")
	var spear = spear_scene.instantiate()
	_spawn_direction = Vector2.from_angle(_aim_angle-PI/2)
	spear.position = Vector2(characther.position + spear_spawn_offset + _spawn_direction*spawn_distance_from_center)

	spear.rotation = _aim_angle
	spear.apply_impulse(_spawn_direction*max_throw_speed*_charge) 
	player.add_child(spear)

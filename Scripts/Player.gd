extends CharacterBody2D

var throwSpeedBar : ProgressBar
var aimArrow : Node

@export var charge_time: float = 1.5
@export var recharge_time: float = 0.5
@export var spear_spawn_offset: Vector2 = Vector2(0, -70)
@export var spawn_distance_from_center : float = 100
@export var max_throw_speed: float = 1000.0
@export var rotation_speed = 1.5

@export var movement_speed = 400

var _charge = 0 #Float between 0 and 1
var _aim_angle = 0
var _rotation_direction = 0
var _spawn_direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	throwSpeedBar = $ThrowSpeedBar
	aimArrow = $AimArrow

func update_arrow():
	aimArrow.rotation = _aim_angle

func update_bar():
	throwSpeedBar.value = _charge*throwSpeedBar.max_value

func throw_spear():
	var spear_scene = preload("res://Scenes/spear.tscn")
	var spear = spear_scene.instantiate()
	_spawn_direction = Vector2.from_angle(_aim_angle-PI/2)
	spear.position = Vector2(position + spear_spawn_offset + _spawn_direction*spawn_distance_from_center)
	#spear.position = Vector2(300, -300)

	spear.rotation = _aim_angle
	spear.apply_impulse(_spawn_direction*max_throw_speed*_charge) 
	owner.add_child(spear)
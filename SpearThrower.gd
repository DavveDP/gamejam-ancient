extends Node2D

var throwSpeedBar : ProgressBar
var parent : Node

@export var chargeTime: float = 1.5

var charge = 0 #Float between 0 and 1

# Called when the node enters the scene tree for the first time.
func _ready():
	throwSpeedBar = $ThrowSpeedBar
	parent = get_parent().get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("charge_spear"):
		charge += delta/chargeTime
		updateBar()
		
	if Input.is_action_just_released("charge_spear"):
		spawnSpear()
		resetCharge()
		updateBar()
		
func updateBar():
	throwSpeedBar.value = charge*throwSpeedBar.max_value
	
func resetCharge():
	charge = 0.0

func spawnSpear():
	var spear_scene = preload("res://spear.tscn")
	var spear = spear_scene.instantiate()
	spear.position = Vector2(0, -1000)
	spear.apply_central_force(Vector2(0, -20000 ))
	parent.add_child(spear)

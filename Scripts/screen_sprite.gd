@tool
extends Sprite2D
class_name ScreenSprite2D

@export var width: float = 1.0;
@export var height: float = 1.0;

func _ready():
	print('hello')

func _process(_delta):
	centered = false;
	region_enabled = true;
	region_rect = Rect2(position.x, position.y, get_viewport().size.x * width, get_viewport().size.y * height);
	print('hello')
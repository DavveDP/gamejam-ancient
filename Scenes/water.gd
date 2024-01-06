@tool
extends Sprite2D

func set_aspect_ratio():
	material.set_shader_parameter("aspect_ratio", scale.y / scale.x)
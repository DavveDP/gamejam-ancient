extends Node2D

var fish_pool: Array = [20]
var active_fish: Array = [20]
@export var fish_lifetime: float = 2.0
@export var spawn_area: NodePath = NodePath()

func _ready():
	fish_pool = get_all_fish()
	fish_pool.map(disable_node)

var accumulated_time = 0.0

func _process(delta):	

	accumulated_time += delta
	if (accumulated_time < 1):
		return
	
	accumulated_time = 0.0

	var fish = spawn_random_fish()
	var timer = get_tree().create_timer(fish_lifetime)
	timer.timeout.connect(func(): despawn_fish(fish))

func get_all_fish():
	return $FishPool.get_children().filter(func(n): return n is Sprite2D)

func spawn_random_fish() -> Node:
	#Move a free fish from the pool to the active fish dictionary with a lifetime timer
	var free_fish = move_element(fish_pool.front(), fish_pool, active_fish)
	#Set it at a random position within the spawn area
	free_fish.position = get_random_rect_position($spawn_area.get_rect())
	#Enable it
	enable_node(free_fish)
	return free_fish

func despawn_fish(fish: Node):
	disable_node(fish)
	move_element(fish, active_fish, fish_pool)

func move_element(element, from_arr, to_arr):
	from_arr.erase(element)
	to_arr.push_back(element)
	return element

func get_random_rect_position(rect: Rect2) -> Vector2:
	return rect.position + Vector2(randf_range(0, rect.size.x), randf_range(0, rect.size.y))

func enable_node(node: Node):
	node.show();
	node.process_mode = Node.PROCESS_MODE_INHERIT;

func disable_node(node: Node):
	node.hide();
	node.process_mode = Node.PROCESS_MODE_DISABLED;

func set_spawn_area(rect_node: Sprite2D):
	$spawn_area.set_size(
		Vector2(
			rect_node.texture.get_width() * rect_node.scale.x, 
			rect_node.texture.get_height() * rect_node.scale.y
		))

	$spawn_area.set_position(rect_node.position)

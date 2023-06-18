class_name  Piece
extends Node2D

var data
var cells
var board: Board
var current_rotation_index = 0

var step_delay = 1.0
var lock_delay = 0.5

var lock_time = 0


func _ready():
	board = get_tree().get_first_node_in_group("board")
	$StepTimer.connect('timeout', on_step_timer_timeout)

func _process(delta):
	lock_time += delta
	if Input.is_action_just_pressed("move_left"):
		move(Vector2.LEFT)
	elif Input.is_action_just_pressed("move_right"):
		move(Vector2.RIGHT)
	if Input.is_action_just_pressed("move_down"):
		move(Vector2.DOWN)
	if Input.is_action_just_pressed("hard_drop"):
		hard_drop()
	if Input.is_action_just_pressed('rotate_right'):
		rotate_piece(-1)
	if Input.is_action_just_pressed('rotate_left'):
		rotate_piece(1)

func initialize(p, piece_data):
	position = p
	data = piece_data
	cells = piece_data.cells
	current_rotation_index = 0
	$StepTimer.start(step_delay)
	lock_time = 0.0

func step():
	$StepTimer.start(step_delay)
	move(Vector2.DOWN)
	if lock_time > lock_delay:
		lock()

func lock():
	board.set_place(self)
	board.clear_lines()
	board.spawn_piece()

func hard_drop():
	while move(Vector2.DOWN):
		continue
	lock()

func rotate_piece(direction: int):
	var original_rotation_index = current_rotation_index
	current_rotation_index = wrap(current_rotation_index + direction, 0, 4)
	apply_rotation(direction)
	if not test_wallkicks(current_rotation_index, direction):
		current_rotation_index = original_rotation_index
		apply_rotation(-direction)

func apply_rotation(direction: int):
	var local_cells = []
	for i in range(cells.size()):
		var cell: Vector2 = cells[i]
		var x: int
		var y: int
		
		match data.tetromino_type:
			Data.TETROMINO.I, Data.TETROMINO.O:
				cell.x -= 0.5
				cell.y -= 0.5
				x = ceili((cell.x * Data.RotationMatrix[0] * direction) + (cell.y * Data.RotationMatrix[1] * direction))
				y = ceili((cell.x * Data.RotationMatrix[2] * direction) + (cell.y * Data.RotationMatrix[3] * direction))
			_:
				x = roundi((cell.x * Data.RotationMatrix[0] * direction) + (cell.y * Data.RotationMatrix[1] * direction))
				y = roundi((cell.x * Data.RotationMatrix[2] * direction) + (cell.y * Data.RotationMatrix[3] * direction))
		cell = Vector2(x,y)
		local_cells.append(cell)
	cells = local_cells

func test_wallkicks(rotation_index: int, rotation_direction: int) -> bool:
	var wallkick_index = get_wallkick_index(rotation_index, rotation_direction)
	for i in range(data.wall_kicks[0].size()):
		var translation = data.wall_kicks[wallkick_index][i]
		if move(translation):
			return true
	return false

func get_wallkick_index(rotation_index: int, rotation_direction: int) -> int:
	var wallkick_index := rotation_index * 2
	if rotation_direction < 0:
		wallkick_index -= 1
	return wrap(wallkick_index, 0, data.wall_kicks.size())

func move(translation: Vector2) -> bool:
	var new_position = position
	new_position.x += translation.x
	new_position.y += translation.y
	var valid = board.is_move_valid(self, new_position)
	if valid:
		board.clear_piece()
		position = new_position
		board.set_piece(self)
		lock_time = 0
	return valid
	
func on_step_timer_timeout():
	step()

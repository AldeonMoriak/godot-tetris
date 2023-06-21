extends TileMap

@onready var board: Board = get_tree().get_first_node_in_group('board')
@onready var piece: Piece = get_tree().get_first_node_in_group('piece')

var cells: Array[Vector2]

func _ready():
	for i in range(4):
		cells.append(Vector2.ZERO)

func _process(_delta):
	clear()
	copy()
	drop()
	set_ghost()

func copy():
	for i in range(piece.cells.size()):
		cells[i] = piece.cells[i]

func drop():
	var piece_position = piece.position
	var current_row = piece_position.y
	var bottom = board.grid_size.y - 1
	var row = current_row
	while row <= bottom:
		piece_position.y = row
		if board.is_move_valid(piece, piece_position):
			position = piece_position
		else:
			break
		row += 1

func set_ghost():
	for cell in cells:
		var tile_position = cell + position
		set_cell(0, Vector2i(tile_position), 1, Vector2i(0,0), 0)

	

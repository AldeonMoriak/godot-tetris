extends TileMap

var board: Board
@onready var piece: Piece = get_tree().get_first_node_in_group('piece')

var next_piece_board

var spawn_position = Vector2(1,1)

var cells = []
var cell_type: int


func initialize(indices):
	board = get_tree().get_first_node_in_group('board')
	clear()
	copy(indices)
	set_pieces()

func copy(indices: Array[int]):
	cells = []
	for i in indices:
		var next_cells = board.tetrominoes[i]
		cells.append(next_cells)

func set_pieces():
	var i = 0
	var temp_spawn_position = spawn_position
	for group in cells:
		for cell in group.cells:
			temp_spawn_position = Vector2(spawn_position.x, spawn_position.y + (i * 3))
			if  group.tetromino_type == Data.TETROMINO.O:
				temp_spawn_position = Vector2(temp_spawn_position.x, temp_spawn_position.y - 1)
			var tile_position = cell + temp_spawn_position
			set_cell(0, Vector2i(tile_position), group.tile_id, Vector2i(0,0), 0)
		i += 1

	

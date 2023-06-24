extends TileMap

var board: Board
@onready var piece: Piece = get_tree().get_first_node_in_group('piece')

var next_piece_board

var spawn_position = Vector2(1,1)

var cells = []
var tile_id: int


func initialize(data):
	clear()
	copy(data)
	set_pieces()

func copy(data):
	cells = data.cells
	tile_id = data.tile_id

func set_pieces():
	for cell in cells:
		var tile_position = cell + spawn_position
		set_cell(0, Vector2i(tile_position), tile_id, Vector2i(0,0), 0)

	

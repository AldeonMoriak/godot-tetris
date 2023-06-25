class_name Board
extends TileMap
var tile_size = tile_set.tile_size
var half_tile_size = tile_size / 2
@export var spawn_position := Vector2(4,0)
@onready var next_piece_board = get_tree().get_first_node_in_group('next_piece')
@onready var reserved_piece_board = get_tree().get_first_node_in_group('reserved_piece')
var reserved_piece
var piece: Piece
var grid_size = Vector2(10,20)
var grid = []

var moves: Array[int] = []

@export var tetromino_type: Data.TETROMINO
var tetrominoes = {
	Data.TETROMINO.I: {},
	Data.TETROMINO.O: {},
	Data.TETROMINO.T: {},
	Data.TETROMINO.J: {},
	Data.TETROMINO.L: {},
	Data.TETROMINO.S: {},
	Data.TETROMINO.Z: {}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	piece = get_tree().get_first_node_in_group('piece')
	for i in Data.TETROMINO:
		tetrominoes[Data.TETROMINO[i]] = {
			"cells": Data.Cells[Data.TETROMINO[i]],
			"tetromino_type": Data.TETROMINO[i],
			"wall_kicks": Data.WallKicks[Data.TETROMINO[i]],
			"tile_id": Data.tile_ids[Data.TETROMINO[i]]
		}
	start_grid()
	spawn_piece()

func start_grid():
	grid.clear()
	for y in range(grid_size.y):
		grid.append([])
		for x in range(grid_size.x):
			grid[y].append(null)

func spawn_piece():
	if moves.size() < 5:
		for i in range(5 - moves.size()):
			var random = randi() % tetrominoes.size()
			moves.append(random)
	var random = moves.pop_front()
	var data = tetrominoes[random]
	next_piece_board.initialize(moves)
	piece.initialize(spawn_position, data)
	if is_move_valid(piece, spawn_position):
		set_piece(piece)
	else:
		game_over()

func game_over():
	clear()
	start_grid()
	spawn_piece()
	reserved_piece = null
	reserved_piece_board.clear()

func swap_reserved_piece():
	var temp = piece.data
	if reserved_piece:
		piece.initialize(spawn_position, reserved_piece)
	else:
		spawn_piece()
	reserved_piece = temp
	reserved_piece_board.initialize(reserved_piece)
		

func set_piece(node, is_permanent = false):
	for i in range(node.cells.size()):
		var tile_position = node.cells[i] + node.position
		if is_permanent:
			grid[tile_position.y][tile_position.x] = 'cell'
		set_cell(0, Vector2i(tile_position), node.data.tile_id, Vector2i(0,0), 0)

func clear_piece(node):
	for cell in node.cells:
		var tile_position = cell + node.position
		erase_cell(0, Vector2i(tile_position))

func clear_lines():
	var row = grid_size.y - 1
	while row >= 0:
		if is_line_full(row):
			clear_line(row)
		else:
			row -= 1

func is_line_full(row: int)-> bool:
	for col in grid[row]:
		if col == null:
			return false
	return true

func clear_line(row: int):
	for i in range(grid[row].size()):
		grid[row][i] = null
		erase_cell(0, Vector2i(i, row))
	while row > 0:
		for col_index in range(grid[0].size()):
			grid[row][col_index] = grid[row - 1][col_index]
			var cell_source_id = get_cell_source_id(0, Vector2i(col_index, row - 1))
			set_cell(0, Vector2i(col_index, row), cell_source_id, Vector2i(0,0))
		row -= 1

func is_move_valid(p, new_position):
	for cell_position in p.cells:
		var tile_position: Vector2 = cell_position + new_position
		if tile_position.x < 0 or tile_position.x >= grid_size.x or tile_position.y >= grid_size.y:
			return false
		if grid[tile_position.y][tile_position.x] and tile_position.y >= 0 and tile_position.x >= 0:
			return false
	return true


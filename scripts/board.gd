class_name Board
extends TileMap
var tile_size = tile_set.tile_size
var half_tile_size = tile_size / 2
@export var spawn_position := Vector2(4,0)
@onready var cyan = preload("res://scenes/cells/cyan.tscn")
@onready var yellow = preload("res://scenes/cells/yellow.tscn")
@onready var purple = preload("res://scenes/cells/purple.tscn")
@onready var blue = preload("res://scenes/cells/blue.tscn")
@onready var orange = preload("res://scenes/cells/orange.tscn")
@onready var green = preload("res://scenes/cells/green.tscn")
@onready var red = preload("res://scenes/cells/red.tscn")
@onready var sprites = {
	Data.TETROMINO.I: cyan,
	Data.TETROMINO.O: yellow,
	Data.TETROMINO.T: purple,
	Data.TETROMINO.J: blue,
	Data.TETROMINO.L: orange,
	Data.TETROMINO.S: green,
	Data.TETROMINO.Z: red
}
@onready var piece_scene = preload("res://scenes/piece.tscn")
var piece
var grid_size = Vector2(10,20)
var grid = []

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
	piece = piece_scene.instantiate()
	call_deferred("add_sibling", piece)
	for i in Data.TETROMINO:
		tetrominoes[Data.TETROMINO[i]] = {
			"cells": Data.Cells[Data.TETROMINO[i]],
			"sprite": sprites[Data.TETROMINO[i]],
			"tetromino_type": Data.TETROMINO[i],
			"wall_kicks": Data.WallKicks[Data.TETROMINO[i]]
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
	var random = randi() % tetrominoes.size()
	var data = tetrominoes[random]
	var p = map_to_local(spawn_position)
	piece.initialize(spawn_position, data)
	if is_move_valid(piece, spawn_position):
		set_piece(piece)
	else:
		game_over()

func game_over():
	start_grid()
	for child in get_children():
		child.call_deferred('queue_free')

func set_place(node):
	for i in range(node.cells.size()):
		var tile_position = node.cells[i] + node.position
		var cell = node.data.sprite.instantiate()
		var local_pos = map_to_local(tile_position)
		cell.position = local_pos
		grid[tile_position.y][tile_position.x] = cell
		clear_piece()
		add_child(cell)

func set_piece(node):
	for i in range(node.cells.size()):
		var tile_position = node.cells[i] + node.position
		var cell = node.data.sprite.instantiate()
		var local_pos = map_to_local(tile_position)
		cell.position = local_pos
#		grid[tile_position.x][tile_position.y] = 'cell'
		piece.add_child(cell)

func clear_piece():
	for child in piece.get_children():
		if "Timer" not in child.name:
			child.call_deferred('queue_free')

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
	for col in grid[row]:
		var cell = col
		cell.call_deferred('queue_free')
		col = null
	while row > 0:
		for col_index in range(grid[0].size()):
			var cell = grid[row - 1][col_index]
			if cell:
				print(cell.position)
				cell.position.y = cell.position.y + tile_size.y
			grid[row][col_index] = grid[row - 1][col_index]
			
		row -= 1

func is_move_valid(p, new_position):
	for cell_position in p.cells:
		var tile_position: Vector2 = cell_position + new_position
		if tile_position.x < 0 or tile_position.x >= grid_size.x or tile_position.y < 0 or tile_position.y >= grid_size.y:
			return false
		if grid[tile_position.y][tile_position.x]:
			return false
	return true


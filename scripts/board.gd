extends TileMap
var tile_size = tile_set.tile_size
var half_tile_size = tile_size / 2
@onready var cyan = preload("res://scenes/cells/cyan.tscn")
@onready var yellow = preload("res://scenes/cells/yellow.tscn")
@onready var purple = preload("res://scenes/cells/purple.tscn")
@onready var blue = preload("res://scenes/cells/blue.tscn")
@onready var orange = preload("res://scenes/cells/orange.tscn")
@onready var green = preload("res://scenes/cells/green.tscn")
@onready var red = preload("res://scenes/cells/red.tscn")
@onready var sprites = {
	TETROMINO.I: cyan,
	TETROMINO.O: yellow,
	TETROMINO.T: purple,
	TETROMINO.J: blue,
	TETROMINO.L: orange,
	TETROMINO.S: green,
	TETROMINO.Z: red
}
var grid_size = Vector2(10,20)
var grid = []
enum TETROMINO {
	I,
	O,
	T,
	J,
	L,
	S,
	Z
}
@export var tetromino_type: TETROMINO
var tetrominoes = {
	TETROMINO.I: {},
	TETROMINO.O: {},
	TETROMINO.T: {},
	TETROMINO.J: {},
	TETROMINO.L: {},
	TETROMINO.S: {},
	TETROMINO.Z: {}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in TETROMINO:
		tetrominoes[TETROMINO[i]] = {
			"cells": Cells[TETROMINO[i]],
			"sprite": sprites[TETROMINO[i]]
		}
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	var positions = []
	for n in range(5):
		var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		if not grid_pos in positions:
			positions.append(grid_pos)
	for pos in positions:
		var cell = tetrominoes[0].sprite.instantiate()
		var local_pos = map_to_local(Vector2(0,0))
		cell.position = local_pos
		grid[pos.x][pos.y] = 'cell'
		add_child(cell)
	print(tile_size)
#		self.set_cell(0, Vector2(0,0),tetrominoes[TETROMINO.I].sprite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



var cos = cos(PI / 2)
var sin = sin(PI / 2)
var RotationMatrix = [cos, sin, -sin, cos ]

var Cells = {
	TETROMINO.I: [  Vector2(-1, 1), Vector2( 0, 1), Vector2( 1, 1), Vector2( 2, 1) ],
	TETROMINO.J: [ Vector2(-1, 1), Vector2(-1, 0), Vector2( 0, 0), Vector2( 1, 0) ],
	TETROMINO.L: [ Vector2( 1, 1), Vector2(-1, 0), Vector2( 0, 0), Vector2( 1, 0) ],
	TETROMINO.O: [ Vector2( 0, 1), Vector2( 1, 1), Vector2( 0, 0), Vector2( 1, 0) ],
	TETROMINO.S: [ Vector2( 0, 1), Vector2( 1, 1), Vector2(-1, 0), Vector2( 0, 0) ],
	TETROMINO.T: [ Vector2( 0, 1), Vector2(-1, 0), Vector2( 0, 0), Vector2( 1, 0) ],
	TETROMINO.Z: [ Vector2(-1, 1), Vector2( 0, 1), Vector2( 0, 0), Vector2( 1, 0) ]
}

var WallKicksI = [
		[ Vector2(0, 0), Vector2(-2, 0), Vector2( 1, 0), Vector2(-2,-1), Vector2( 1, 2) ],
		[ Vector2(0, 0), Vector2( 2, 0), Vector2(-1, 0), Vector2( 2, 1), Vector2(-1,-2) ],
		[ Vector2(0, 0), Vector2(-1, 0), Vector2( 2, 0), Vector2(-1, 2), Vector2( 2,-1) ],
		[ Vector2(0, 0), Vector2( 1, 0), Vector2(-2, 0), Vector2( 1,-2), Vector2(-2, 1) ],
		[ Vector2(0, 0), Vector2( 2, 0), Vector2(-1, 0), Vector2( 2, 1), Vector2(-1,-2) ],
		[ Vector2(0, 0), Vector2(-2, 0), Vector2( 1, 0), Vector2(-2,-1), Vector2( 1, 2) ],
		[ Vector2(0, 0), Vector2( 1, 0), Vector2(-2, 0), Vector2( 1,-2), Vector2(-2, 1) ],
		[ Vector2(0, 0), Vector2(-1, 0), Vector2( 2, 0), Vector2(-1, 2), Vector2( 2,-1) ],
]

var WallKicksJLOSTZ = [
		[ Vector2(0, 0), Vector2(-1, 0), Vector2(-1, 1), Vector2(0,-2), Vector2(-1,-2) ],
		[ Vector2(0, 0), Vector2( 1, 0), Vector2( 1,-1), Vector2(0, 2), Vector2( 1, 2) ],
		[ Vector2(0, 0), Vector2( 1, 0), Vector2( 1,-1), Vector2(0, 2), Vector2( 1, 2) ],
		[ Vector2(0, 0), Vector2(-1, 0), Vector2(-1, 1), Vector2(0,-2), Vector2(-1,-2) ],
		[ Vector2(0, 0), Vector2( 1, 0), Vector2( 1, 1), Vector2(0,-2), Vector2( 1,-2) ],
		[ Vector2(0, 0), Vector2(-1, 0), Vector2(-1,-1), Vector2(0, 2), Vector2(-1, 2) ],
		[ Vector2(0, 0), Vector2(-1, 0), Vector2(-1,-1), Vector2(0, 2), Vector2(-1, 2) ],
		[ Vector2(0, 0), Vector2( 1, 0), Vector2( 1, 1), Vector2(0,-2), Vector2( 1,-2) ]
]

var WallKicks = {
		 TETROMINO.I: WallKicksI,
		 TETROMINO.J: WallKicksJLOSTZ,
		 TETROMINO.L: WallKicksJLOSTZ,
		 TETROMINO.O: WallKicksJLOSTZ,
		 TETROMINO.S: WallKicksJLOSTZ,
		 TETROMINO.T: WallKicksJLOSTZ,
		 TETROMINO.Z: WallKicksJLOSTZ
}

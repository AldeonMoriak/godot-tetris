class_name StaticData

enum TETROMINO {
	I,
	O,
	T,
	J,
	L,
	S,
	Z
}

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

extends Node

func apply_camera_shake():
	var camera: CustomCamera = get_tree().get_first_node_in_group('camera')
	if camera:
		camera.apply_shake()

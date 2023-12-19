extends Camera2D
class_name CustomCamera

func apply_shake():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "zoom", Vector2(0.91,0.91), 0.1)
	tween.tween_property(self, "zoom", Vector2(0.9,0.9), 0.05)

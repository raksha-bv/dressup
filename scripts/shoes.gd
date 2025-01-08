extends Node2D


var draggable = false
var is_in_drop = false
var body_ref
var offset: Vector2
var initialPos: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if draggable: 
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position()
			
		elif Input.is_action_just_released("click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_in_drop:
				tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("shoe"):
		is_in_drop = true
		body_ref = body
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("shoe"):
		is_in_drop = false
		body_ref = body


func _on_area_2d_mouse_entered() -> void:
	if not Global.is_dragging:
		draggable = true
		#scale = Vector2(0.35, 0.35)


func _on_area_2d_mouse_exited() -> void:
	if not Global.is_dragging:
		draggable = false
		#scale = Vector2(0.3, 0.3)

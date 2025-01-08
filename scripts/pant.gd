extends Node2D

var draggable = false
var is_in_drop = false
var body_ref
var offset: Vector2
var initialPos: Vector2

func _ready() -> void:
	initialPos = global_position

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
				# Check if there's already pants in the drop zone
				var existing_pants = get_tree().get_nodes_in_group("worn_pants")
				for pants in existing_pants:
					if pants != self:
						# Return the existing pants to its original position
						var return_tween = get_tree().create_tween()
						pants.remove_from_group("worn_pants")
						return_tween.tween_property(pants, "global_position", pants.initialPos, 0.2).set_ease(Tween.EASE_OUT)
				
				# Place the new pants
				tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
				add_to_group("worn_pants")
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)
				remove_from_group("worn_pants")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("pant"):
		is_in_drop = true
		body_ref = body
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("pant"):
		is_in_drop = false
		body_ref = body

func _on_area_2d_mouse_entered() -> void:
	if not Global.is_dragging:
		draggable = true

func _on_area_2d_mouse_exited() -> void:
	if not Global.is_dragging:
		draggable = false

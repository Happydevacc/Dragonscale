extends ActionInteractable

var state : bool = false
var body_array : Array = []


func _on_body_entered(body):
	if body is MoveableObject or body is Player:
		body_array.append(body)
		state = true
		$Sprite2D.frame = 1
		EVENTBUS.action_interactable_triggered.emit()


func _on_body_exited(body):
	for old_body in body_array:
		if old_body == body:
			body_array.remove_at(body_array.find(body))
	if body_array.size() < 1:
		state = false
		$Sprite2D.frame = 0
		EVENTBUS.action_interactable_triggered.emit()

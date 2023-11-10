extends ActionInteractable

@export var has_timer : bool = false
@export var timer_time : float = 0

var state : bool = false : set = set_state



func take_damage(_damage, type):
	if type == "fire":
		$SpriteFire.visible = true
		state = true
		EVENTBUS.action_interactable_triggered.emit()


func set_state(new_value):
	state = new_value
	if new_value:
		if has_timer:
			$Timer.start()


func _on_timer_timeout():
	state = false
	$SpriteFire.visible = false

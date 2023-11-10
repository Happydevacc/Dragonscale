extends ActionInteractable


var state : bool = false


func take_damage(_damage, _type):
	print("yes")
	if state:
		%Sprite2D.frame = 1
		state = false
		EVENTBUS.action_interactable_triggered.emit()
	else:
		%Sprite2D.frame = 0
		state = true
		EVENTBUS.action_interactable_triggered.emit()




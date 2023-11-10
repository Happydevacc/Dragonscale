class_name Door
extends StaticBody2D

@export var is_interactable : bool = false
@export var has_key : bool = false
@export var key_array : Array[ActionInteractable]


var state : bool = false : set = set_state

func _ready():
	EVENTBUS.action_interactable_triggered.connect(on_action_interactable_triggered)


func on_action_interactable_triggered():
	var new_state : bool = true
	if has_key:
		for key in key_array:
			if key:
				if !key.state:
					new_state = false
			if new_state != state:
				self.state = new_state

func set_state(new_value):
	if new_value:
		%Sprite2D.frame = 1
		%CollisionShape2D.set_deferred("disabled", true)
	else:
		%Sprite2D.frame = 0
		%CollisionShape2D.set_deferred("disabled", false)
	state = new_value

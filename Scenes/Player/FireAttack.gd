extends Area2D

@export var speed : int = 100

var damage : float = 0
var type: String = "fire"
var direction : Vector2 = Vector2.ZERO


func _physics_process(delta):
	position += direction * speed * delta



func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage, type)
	set_deferred("monitoring", false)
	self.queue_free()



func _on_timer_timeout():
	set_deferred("monitoring", false)
	self.queue_free()

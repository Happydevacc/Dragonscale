extends Area2D

var damage : float = 0
var type: String = ""


func _on_body_entered(body):
	print(body)
	if body.has_method("take_damage"):
		body.take_damage(damage, type)


func _on_timer_timeout():
	monitoring = false
	self.queue_free()

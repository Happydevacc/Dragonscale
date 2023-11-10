class_name Enemy
extends CharacterBody2D

@export var damage : int = 1
@export var max_hitpoint : int = 3
@export var attack_range : float
@export var speed : int = 300

var hitpoint : int
var target : CharacterBody2D
var direction : Vector2

func _ready():
	hitpoint = max_hitpoint


func _physics_process(_delta):
	if target:
		direction = (target.position - self.position).normalized()
		velocity = direction * speed
		move_and_slide()
		if self.global_position.distance_to(target.global_position) <= attack_range:
			attack()


func attack():
	#enter code for direction analyse
	if target:
		target.take_damage(damage)


func take_damage(amount, _type):
	hitpoint = clamp(hitpoint - amount, 0, max_hitpoint)
	if hitpoint <= 0:
		#later add death animation
		queue_free()




func _on_detection_area_body_entered(body):
	if body is Player:
		target = body
		direction = (position - target.position).normalized()

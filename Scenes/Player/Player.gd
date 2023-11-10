class_name Player
extends CharacterBody2D

@onready var basic_attack : PackedScene = preload("res://Scenes/Player/PlayerAttack.tscn")
@onready var fire_attack : PackedScene = preload("res://Scenes/Player/FireAttack.tscn")

@export var animation_player : AnimationPlayer
@export var camera : Camera2D
@export var raycast_interactable : RayCast2D

#for ease of access as export
@export var raycast_length : int = 50
@export var speed = 300.0
@export var damage : int = 1
@export var max_hitpoint : int = 3
@export var hitpoint : int = 3

var facing_direction : Vector2
var is_attacking : bool = false


func _ready():
	pass


func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		facing_direction = direction
		raycast_interactable.target_position = direction * raycast_length
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	move_and_slide()


func _unhandled_input(event):
	if event.is_action_pressed("left",true):
		$Sprite2D.texture = load("res://Assets/Creatures/DragonSpritesLeft.png")
		$Sprite2D.flip_h = false
		$AnimationPlayer.play("Walk")
	elif event.is_action_pressed("right",true):
		$Sprite2D.texture = load("res://Assets/Creatures/DragonSpritesLeft.png")
		$Sprite2D.flip_h = true
		$AnimationPlayer.play("Walk")
	elif event.is_action_pressed("up",true):
		$Sprite2D.texture = load("res://Assets/Creatures/DragonSpritesUp.png")
		$Sprite2D.flip_h = false
		$AnimationPlayer.play("Walk")
	elif event.is_action_pressed("down",true):
		$Sprite2D.texture = load("res://Assets/Creatures/DragonSpritesDown.png")
		$Sprite2D.flip_h = false
		$AnimationPlayer.play("Walk")
	elif event.is_action_pressed("action_a"):
		$AnimationPlayer.play("AttackFireball")
	else:
		$AnimationPlayer.play("Idle")
		pass
	
	
	if event.is_action_pressed("action_a"):
#		interact(raycast_interactable.get_collider()) #right now to interact
		#improvised fire_attack
		var new_attack = fire_attack.instantiate()
		add_child(new_attack)
		new_attack.damage = self.damage
		new_attack.direction = self.facing_direction
		new_attack.position = facing_direction * 26
	if event.is_action_pressed("action_b"):
		#temporary attack code
		$Sprite2D.offset = facing_direction * 15
		is_attacking = true
		$Timer.start()
		var new_attack = basic_attack.instantiate()
		add_child(new_attack)
		new_attack.damage = self.damage
		new_attack.position = facing_direction * 20


func interact(body):
	if body:
		if body.has_method("interactable"):
			body.interactable()
		else:
			print(body)


func take_damage(amount, _type):
	hitpoint = clamp(hitpoint - amount, 0, max_hitpoint)
	if hitpoint == 0:
		#gameover animation and screen
		pass


func _on_timer_timeout():
	$Sprite2D.offset = Vector2.ZERO

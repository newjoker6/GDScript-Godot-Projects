extends KinematicBody2D


var velocity:= Vector2.ZERO
var speed:= -1


func _ready():
	velocity.x = speed
	velocity.y = speed


func _process(delta):
	move_and_collide(velocity)

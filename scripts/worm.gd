extends CharacterBody2D

## @export is tag that can be applied to variables to add them onto the property tab in the editor
## You can then change the values in the editor instead of having to go into the code
@export var flap_height : int = -125
@export var gravity : float = 250

## The worm gets it's own soundplayer because the sounds the worm makes is asynchronous to the main games sound
@onready var worm_sound_player = $WormSoundPlayer

## Signals are easy ways to send information to other nodes, you can connected them via the Node tab on the left
## All nodes have buildt in signals but you can make your own custom signals like so
signal hit
signal scored

## The ready function is triggered the very first time the node loads into a scene
## Use this to set up the node when it loads in
func _ready():
	worm_sound_player.stream = preload("res://sounds/jetpackFlap.wav")

## The process function is called continously as the game window is open
func _physics_process(delta):
	
	## This is an example of capturing input
	if Input.is_action_just_pressed("jump"):
		velocity.y = flap_height
		worm_sound_player.play()
	
	## The delta variable is just the time elasped between two frames, we use it
	## to make character movement not frame dependent
	velocity.y += gravity * delta
	
	if velocity.y > 250:
		velocity.y = 250
	
	move_and_slide()

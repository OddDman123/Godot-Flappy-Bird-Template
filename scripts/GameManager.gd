extends Node2D

## An Example of making your own property using the @export tag
@export var screw_scene : PackedScene

## An Example of Type Casting a variable
var score : int = 0
## Whether or not the game is playing currently
var running = false
## The starting position of the worm when the game starts
var worm_start : Vector2 = Vector2(56,128)

var screws : Array[Node2D] = []

## An example of using an onready tag
## For me, I use onready for nodes that I don't want to save as scenes
@onready var label = $Label
@onready var worm = $Worm
@onready var timer = $Timer
@onready var sound_player = $SoundPlayer

## The ready function is triggered the very first time the node loads into a scene
## Use this to set up the node when it loads in
func _ready():
	reset()

## The process function is called continously as the game window is open
func _process(_delta):
	## Update the text label every frame
	label.set_text(str(score))
	
	if !running and Input.is_action_just_pressed("jump"):
		start()

## This function turns the game off, off in this case meaning no movement
func reset():
	worm.position = worm_start
	
	## This may look weird to a new-coming, whether or not a node is updating with the application can be toggled
	worm.process_mode = Node.PROCESS_MODE_DISABLED
	
	timer.autostart = false
	timer.stop()
	
	## An example of how a for loop looks
	for screw in screws:
		if is_instance_valid(screw): ## This is needed or else you encounter an error
			screw.queue_free()
	
	running = false
	

## Starts the Flappy bird Game
func start():
	worm.process_mode = Node.PROCESS_MODE_INHERIT
	
	timer.autostart = true
	timer.start()
	
	running = true

func _on_worm_hit():
	## You have to change the sound players stream everytime you want to play something new
	## Preload just loads the file provided before the node containg the script loads
	sound_player.stream = preload("res://sounds/hit.wav")
	
	sound_player.play()
	score = 0
	reset()


func _on_worm_scored():
	## You have to change the sound players stream everytime you want to play something new
	sound_player.stream = preload("res://sounds/scoreUp.wav")
	
	sound_player.play()
	score += 1


func _on_timer_timeout():
	## This is an example on how to spawn in scenes into another scene while the game is running
	var e = screw_scene.instantiate()
	var height = randi_range(-20,20)
	
	e.position = Vector2(296, 128 + height)
	
	screws.append(e)
	
	add_child(e)

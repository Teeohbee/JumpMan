extends CharacterBody2D

var move_speed = 100.0
var jump_force = 200.0
var gravity = 500.0
var score: int = 0
@onready var score_text = get_node("CanvasLayer/ScoreText")

func _ready():
	get_node( "AnimatedSprite2D" ).set_flip_h( true )

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = 0
	
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= move_speed
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += move_speed
		
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = -jump_force
		
	move_and_slide()
	
	if global_position.y >= 155:
		game_over()
	
func game_over():
	get_tree().paused = true
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()
	get_tree().paused = false

func add_score(amount):
	score += amount
	score_text.text = str("Score: ", score)


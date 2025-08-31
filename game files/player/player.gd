extends CharacterBody2D
class_name Player

const SPEED:int = 100
const ROLL_SPEED:int = 125

@onready var animTree:AnimationTree = $AnimationTree
@onready var playback:AnimationNodeStateMachinePlayback = animTree.get("parameters/StateMachine/playback")

var inputVector:Vector2
var lastInputVector:Vector2

func _physics_process(_delta: float) -> void:
	match (playback.get_current_node()):
		"MoveState": Move()
		"AttackState": pass
		"RollState": Roll()

func Move() -> void:
	inputVector = Input.get_vector("left", "right", "up", "down")
			
	if inputVector:
		lastInputVector = inputVector 
		UpdateBlendPosition(inputVector * Vector2(1, -1))
			
	CheckAction("attack", "AttackState")
	CheckAction("roll", "RollState")
			
	velocity = inputVector * SPEED
	move_and_slide()

func Roll() -> void:
	velocity = lastInputVector * ROLL_SPEED
	move_and_slide()

func CheckAction(action:String, state:String) -> void:
	if Input.is_action_just_pressed(action):
		playback.travel(state)

func UpdateBlendPosition(direction:Vector2) -> void:
	animTree.set("parameters/StateMachine/MoveState/running/blend_position", direction)
	animTree.set("parameters/StateMachine/MoveState/standing/blend_position", direction)
	animTree.set("parameters/StateMachine/AttackState/blend_position", direction)
	animTree.set("parameters/StateMachine/RollState/blend_position", direction)

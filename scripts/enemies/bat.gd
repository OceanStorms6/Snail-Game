extends CharacterBody2D
class_name Bat


const SPEED:int = 50
const friction:int = 200

@onready var sprite:Sprite2D = $"bat sprite"
@onready var playback:AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/StateMachine/playback")
@onready var ray_cast_2d: RayCast2D = $RayCast2D

var attack:int = 1
var playerInSight:Player

func _physics_process(delta: float) -> void:
	var state:String = playback.get_current_node()
	match state:
		"Idle": pass
		"Chase": 
			if playerInSight:
				velocity = global_position.direction_to(playerInSight.global_position) * SPEED
				sprite.scale.x = sign(velocity.x)
				move_and_slide()

func PlayerSpotted(player:Player) -> void:
	playerInSight = player
	
func PlayerLost(_player:Player) -> void:
	playerInSight = null

func PlayerVisible() -> bool:
	if !playerInSight: return false
	ray_cast_2d.target_position = playerInSight.global_position - global_position
	return !ray_cast_2d.is_colliding()

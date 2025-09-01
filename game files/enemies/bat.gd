extends CharacterBody2D
class_name Bat

const speed:int = 50
const friction:int = 200

@onready var animTree:AnimationTree = $AnimationTree
@onready var sprite:Sprite2D = $"bat sprite"
@onready var playback:AnimationNodeStateMachinePlayback = animTree.get("parameters/StateMachine/playback")
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var hitbox: Area2D = $hitbox

var playerInSight:Player

func _physics_process(delta: float) -> void:
	var state:String = playback.get_current_node()
	match state:
		"Idle": pass
		"Chase": 
			if playerInSight:
				velocity = global_position.direction_to(playerInSight.global_position) * speed
				sprite.scale.x = sign(velocity.x)
				move_and_slide()
		"Hit":
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			move_and_slide()

func PlayerSpotted(player:Player) -> void:
	playerInSight = player
	
func PlayerLost(_player:Player) -> void:
	playerInSight = null

func PlayerVisible() -> bool:
	if !playerInSight: return false
	ray_cast_2d.target_position = playerInSight.global_position - global_position
	return !ray_cast_2d.is_colliding()

func OnHit(weapon:Weapon) -> void:
	if weapon:
		velocity = weapon.hitDirection * 100
		playback.start("Hit")

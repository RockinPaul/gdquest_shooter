extends CharacterBody2D

signal health_depleted

@onready var happy_boo: Node2D = $HappyBoo
@onready var hurt_box: Area2D = %HurtBox
@onready var progress_bar: ProgressBar = %ProgressBar

var health: float = 100.0
const DAMAGE_RATE = 5.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() != 0.0:
		$HappyBoo.play_walk_animation()
	else:
		$HappyBoo.play_idle_animation()
		
	var overlapping_mobs = hurt_box.get_overlapping_bodies()
	var amount_of_overlapping_mobs = overlapping_mobs.size()
	if amount_of_overlapping_mobs > 0:
		health -= DAMAGE_RATE * amount_of_overlapping_mobs * delta
		progress_bar.value = health
		if health <= 0:
			health_depleted.emit()
			
	

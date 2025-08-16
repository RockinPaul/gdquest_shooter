extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")	
@onready var slime: Node2D = $Slime

var health = 3

func _ready() -> void:
	slime.play_walk()

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100.0
	move_and_slide()


func take_damage():
	health -= 1
	slime.play_hurt()
	
	if health == 0:
		queue_free()
		const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		# Add smoke to the sibling of the mob rather than mob itself,
		# because mob is gets queue_free() by this time.
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		

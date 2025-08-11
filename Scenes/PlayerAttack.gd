extends CharacterBody2D

@export var attack_cooldown := 0.5
var can_attack := true
#Checking if attack input was pressed and can actually attack.
func _process(_delta):
	if Input.is_action_just_pressed("attack") and can_attack:
		perform_attack()

func perform_attack():
	can_attack = false
	$attack_area.monitoring = true  # Enable detection
	await get_tree().create_timer(0.1).timeout  # Small window for attack hit
	$attack_area.monitoring = false
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

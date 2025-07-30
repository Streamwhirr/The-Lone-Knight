# HealthComponent.gd
# A self-contained component for managing health, damage, and death.
class_name HealthComponent

# Signals are like announcements. Other nodes can listen for them.
signal health_changed(new_health)
signal died

# Use @export to make this variable editable in the Godot Inspector.
@export var max_health: float = 100.0

var current_health: float

# This function is called when the node enters the scene tree for the first time.
func _ready():
	# Initialize current health to the maximum value.
	current_health = max_health

# A public function that other nodes can call to deal damage.
func take_damage(amount: float):
	# If already dead, do nothing.
	if current_health <= 0:
		return

	# Subtract the damage amount from current health.
	current_health -= amount

	# Use clamp to ensure health doesn't go below 0.
	current_health = clamp(current_health, 0, max_health)

	# Emit the 'health_changed' signal to notify listeners (like a health bar).
	emit_signal("health_changed", current_health)

	# If health has reached zero, emit the 'died' signal.
	if current_health == 0:
		emit_signal("died")

# A public function for healing.
func heal(amount: float):
	# Can't heal if dead.
	if current_health <= 0:
		return
	
	current_health += amount

	current_health = clamp(current_health, 0, max_health)
	
	emit_signal("health_changed", current_health)

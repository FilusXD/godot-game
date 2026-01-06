extends Path2D
class_name MovingPlatform

@export var path_time := 1.0
@export var pause_time := 0.5  # <--- Nová proměnná pro délku zastavení (v sekundách)
@export var looping := false
@export var ease_type : Tween.EaseType
@export var transition : Tween.TransitionType
@export var path_follow_2D : PathFollow2D

func _ready():
	move_tween()

func move_tween():
	var tween = create_tween()

	if looping:
		tween.set_loops()
		tween.tween_property(path_follow_2D, "progress_ratio", 1.0, path_time)\
			.from(0.0)\
			.set_ease(ease_type)\
			.set_trans(transition)
		# Pokud chceš pauzu i u looping platformy (než se teleportuje na start):
		tween.tween_interval(pause_time) 
		
	else:
		tween.set_loops() # Nastavíme smyčku pro celou sekvenci "tam a zpět"
		
		# Cesta TAM
		tween.tween_property(path_follow_2D, "progress_ratio", 1.0, path_time)\
			.set_ease(ease_type)\
			.set_trans(transition)
		
		# --- PAUZA NA KONCI ---
		tween.tween_interval(pause_time)
		
		# Cesta ZPĚT
		tween.tween_property(path_follow_2D, "progress_ratio", 0.0, path_time)\
			.set_ease(ease_type)\
			.set_trans(transition)
			
		# --- PAUZA NA ZAČÁTKU ---
		tween.tween_interval(pause_time)

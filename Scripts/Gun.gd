extends AnimatedSprite



const Bullet = preload("res://Tests/Bullut.tscn")

onready var ShotAudio = get_node("ShotAudio")
onready var ReloadAudio = get_node("ReloadAudio")
onready var BulletSpawnTimer = get_node("BulletSpawnTimer")
onready var ReloadTimer = get_node("ReloadTimer")
onready var BarrelPoint = get_node("BarrelPoint")


export var bullets : int
export var max_bullets : int
export var bullet_amount : int
export var bullet_spread : float
export var bullet_speed : int
export var reload_time : float = 1
export var bullet_spawn_time : float = 1


var shooting_timer = false
var playing_reload_audio = false

func _ready():
	BulletSpawnTimer.wait_time = bullet_spawn_time
	ReloadTimer.wait_time = reload_time
	bullets = max_bullets



func shoot(target):
	if shooting_timer == false:
				if bullets > 0:
					bullets -= 1
					for amount in bullet_amount:
						var bullet = Bullet.instance()
						bullet.speed = bullet_speed
						bullet.position = BarrelPoint.position
						bullet.rotation = get_parent().get_angle_to(target) -rand_range(-PI / bullet_spread, PI / bullet_spread)
						get_parent().add_child(bullet)
					shooting_timer = true
					BulletSpawnTimer.start()
					ShotAudio.play()
				elif bullets <= 0:
					if not playing_reload_audio:
						print("gotta reload")
						reload()



func reload():
	print("reloadfunction")
	bullets = 0
	ReloadTimer.start()
	ReloadAudio.play()
	playing_reload_audio = true
	


func _on_BulletSpawnTimer_timeout():
	shooting_timer = false

func _on_ReloadTimer_timeout():
	bullets = max_bullets
	print("reloaded", bullets, max_bullets)
	playing_reload_audio = false


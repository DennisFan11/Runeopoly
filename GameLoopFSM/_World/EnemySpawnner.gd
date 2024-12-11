class_name EnemySpawnner 





static var _live_time = 0.0 # 累計時間
static var _level:int = 0 # 當前level

static var _spawn_time = 1.0 # 每隔多久重生
static var _curr_spawn_time = 0.0 
static func update(delta:float, world:World):
	_live_time += delta
	_spawn_time = 1.0/(_live_time/10.0) # 設定重生時間
	
	_curr_spawn_time += delta
	if _curr_spawn_time >= _spawn_time:
		_curr_spawn_time = 0.0
		_spawn(world)

static func start():
	_live_time = 0.0
	_level += 1

static func _spawn(world:World):
	var node = weighted_random_choice().instantiate()
	node.position = world._get_EnemySpawnPoints().pick_random().position
	world.add_child(node)


static var _enemy_scene := [
	[50, preload("res://Unit/Enemy/Skull/Skull.tscn")], # dmg = 10
	[30, preload("res://Unit/Enemy/Apple/Apple.tscn")], # dmg = 15
	[10, preload("res://Unit/Enemy/Sun/Sun.tscn")] # dmg = 50
]

# 根據權重隨機選擇元素的函數
static func weighted_random_choice() -> PackedScene:
	# 計算權重總和
	var total_weight = 0.0
	for i in _enemy_scene:
		total_weight += i[0]
	var random_value = fmod(randi(), total_weight) # 隨機值在 0 到 total_weight - 1 範圍內

	# 遍歷權重，找到對應的元素
	for i in _enemy_scene:
		random_value -= i[0]
		if random_value < 0:
			return i[1]

	return null  # 預防性返回，理論上永遠不會執行到這裡

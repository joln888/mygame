extends CharacterBody2D

const SPEED = 300.0
var energy = 100.0
const MAX_ENERGY = 100.0
const ENERGY_DECREASE_RATE = 5.0  # 每次动作消耗的能量

func _ready():
	# 确保物理处理模式正确
	set_physics_process(true)

func _physics_process(delta):
	# 获取输入方向
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * SPEED
		# 移动时消耗能量
		decrease_energy(ENERGY_DECREASE_RATE * delta)
		# 设置精灵朝向
		if direction.x != 0:
			$Sprite2D.flip_h = direction.x < 0
	else:
		velocity = Vector2.ZERO
		# 站立时恢复能量
		increase_energy(ENERGY_DECREASE_RATE * delta * 0.5)
	
	# 应用移动
	var previous_position = global_position
	move_and_slide()
	
	# 检查是否真的移动了
	if previous_position.distance_to(global_position) < 0.1:
		# 如果被卡住，尝试滑动
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision:
				position += collision.get_normal() * 0.1
	
	# 更新能量条
	update_energy_bar()

func decrease_energy(amount):
	energy = max(0, energy - amount)
	
func increase_energy(amount):
	energy = min(MAX_ENERGY, energy + amount)
	
func update_energy_bar():
	# 使用get_node_or_null避免在找不到节点时报错
	var energy_bar = get_tree().get_root().get_node_or_null("Farm/UI/EnergyBar")
	if energy_bar:
		energy_bar.value = energy

# 工具使用函数
func use_tool():
	if energy >= 10:  # 使用工具需要10点能量
		decrease_energy(10)
		# TODO: 实现工具效果
		return true
	return false

# 种植函数
func plant_seed():
	if energy >= 5:  # 种植需要5点能量
		decrease_energy(5)
		# TODO: 实现种植逻辑
		return true
	return false

# 收获函数
func harvest():
	if energy >= 3:  # 收获需要3点能量
		decrease_energy(3)
		# TODO: 实现收获逻辑
		return true
	return false 
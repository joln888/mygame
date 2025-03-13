extends Control

func _ready():
	# 设置按钮信号连接
	$VBoxContainer/StartButton.pressed.connect(_on_start_button_pressed)
	$VBoxContainer/LoadButton.pressed.connect(_on_load_button_pressed)
	$VBoxContainer/QuitButton.pressed.connect(_on_quit_button_pressed)

func _on_start_button_pressed():
	# TODO: 实现开始新游戏逻辑
	print("开始新游戏")
	# 这里可以添加场景切换代码，例如：
	# get_tree().change_scene_to_file("res://scenes/game/game.tscn")
	
func _on_load_button_pressed():
	# TODO: 实现载入游戏逻辑
	print("载入游戏存档")
	# 这里可以添加载入存档的代码
	
func _on_quit_button_pressed():
	# 退出游戏
	get_tree().quit() 
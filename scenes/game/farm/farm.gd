extends Node2D

# 游戏时间系统
var current_time: float = 6.0  # 游戏开始时间（6:00）
var time_scale: float = 60.0   # 1分钟真实时间 = 1小时游戏时间
var day: int = 1
var season: String = "春"
var year: int = 1

# 季节系统
var seasons = ["春", "夏", "秋", "冬"]
var days_in_season = 28
var current_season_index = 0

func _ready():
	# 初始化UI
	update_time_display()
	update_season_display()

func _process(delta):
	# 更新游戏时间
	current_time += delta * (24.0 / time_scale)
	if current_time >= 24.0:
		current_time = 0.0
		_on_day_end()
	update_time_display()

func _on_day_end():
	day += 1
	if day > days_in_season:
		day = 1
		_on_season_end()

func _on_season_end():
	current_season_index = (current_season_index + 1) % 4
	season = seasons[current_season_index]
	if current_season_index == 0:
		year += 1
	update_season_display()
	# TODO: 更新地图贴图以反映季节变化

func update_time_display():
	var hours = floor(current_time)
	var minutes = floor((current_time - hours) * 60)
	$UI/TimeLabel.text = "%02d:%02d" % [hours, minutes]
	
func update_season_display():
	$UI/SeasonLabel.text = "%s %d年 %d日" % [season, year, day]

# 获取当前时间段（用于调整光照和NPC行为）
func get_day_period() -> String:
	if current_time < 6.0:
		return "dawn"
	elif current_time < 12.0:
		return "morning"
	elif current_time < 17.0:
		return "afternoon"
	elif current_time < 20.0:
		return "evening"
	else:
		return "night" 
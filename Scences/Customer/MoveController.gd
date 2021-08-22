# 客户移动的控制类
# 从屏幕的左边走到屏幕的中间，如过前面已经有客户了，需要和他保持一定的距离

extends Node2D

signal need_speak_signal(roleName)

var force = 80
var speed = 5 # 移动速度的比例
var isSpeaking = false # 是否正在说话
var needMoveOut = false # 需要离开场景

# 角色及对话数据信息
var roleData : RoleData
onready var parent : KinematicBody2D = get_parent()
onready var rayCast = $RayCast2D
onready var worldScene = get_tree().root.get_node("World")
onready var roleLayer = worldScene.find_node("CustomerLayer")

func _ready():
	var settlePanel = worldScene.find_node("SettlementPanel")
	settlePanel.connect("need_move_out", self, "moveOut")


func move(delta):
	var space_state = rayCast.get_world_2d().direct_space_state
	if rayCast.is_colliding() and not needMoveOut: # 不要挤到一起了
		return
	var y = sin(global_position.x / 35) * force
	parent.move_and_slide(Vector2(speed *f orce,y))
	isSpeaking = false
	
func moveOut(roleName):
	if roleName != roleData.roleName:
		return
	print("滚出去")
	needMoveOut = true

# 判断是否需要对话，如果需要对话，则发送需要对话的信号，对话组件内会接收这个信息进行处理
func speak():
	if isSpeaking:
		return
	isSpeaking = true
	emit_signal("need_speak_signal", roleData.roleName)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var root:Viewport = get_node("/root") # 获取根视图，通过根视图来获取显示区域大小
	var centerX = root.get_size_override().x * 0.48 #屏幕中心的位置
	var bodyX = parent.get_global_transform().origin.x #角色的位置
	if bodyX < centerX :
		move(delta)
	elif bodyX < centerX + 100 and not needMoveOut:
		speak()
	elif bodyX < centerX * 2.5:
		move(delta)
	else:
		# 判断是否还有下一个角色，没有的话就需要显示ending了
		checkHasEnding()
		parent.queue_free()

func checkHasEnding():
	var queneEmpty = RoleFactory.hasNext()
	var roleCount = roleLayer.get_child_count()
	if roleCount == 0 and queneEmpty:
		print("显示ending") 

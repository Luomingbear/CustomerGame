# 游戏的世界加载的脚本

extends Node2D

onready var Customer = load("res://Scences/Customer/Customer.tscn")
onready var layer = $CustomerLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	loadDataFromDisk()
	test()
	
	
func test():
	var obj = {
		"roleName" : "101", #角色名
		"dialogueIndex" : "1001", # 当前正在说的话的tetxId
		"dialogMap" : {
			"1001" : {
				"text":"你这个东西质量咋样",
				"option1":{
					"text":"那必须可以",
					"jump":"1002",
					"mood":1
				},
				"option2":{
					"text":"凑合吧",
					"jump":"1002",
					"mood":2
				},
				"option3":{
					"text":"滚",
					"jump":"1003",
					"mood":10
				},
				"option4":{
					"text":"啥玩意啊",
					"jump":"1003",
					"mood":10
				},
				"optionNo":{
					"text":"",
					"jump":"1004",
					"mood":10
				}
			},
			"1002" : {
				"text":"适合我吗",
				"option1":{
					"text":"太适合了",
					"jump":"1002",
					"mood":1
				},
				"option2":{
					"text":"请问您的尺码是？",
					"jump":"1005",
					"mood":2
				},
				"option3":{
					"text":"不适合，你太胖",
					"jump":"1003",
					"mood":10
				},
				"option4":null,
				"optionNo":{
					"text":"",
					"jump":"1004",
					"mood":10
				}
			},
			"1003" : {
				"text":"太过分了",
				"option1":null,
				"option2":null,
				"option3":null,
				"option4":null,
				"optionNo":null
			},
			"1004" : {
				"text":"喂！你在听我说话吗",
				"option1":{
					"text":"在的，亲",
					"jump":"1001",
					"mood":1
				},
				"option2":{
					"text":"不在滚",
					"jump":"1003",
					"mood":2
				},
				"option3":null,
				"option4":null,
				"optionNo":{
					"text":"",
					"jump":"1003",
					"mood":10
				}
			}
		}
	}
	createCustomer(obj)
	
func loadDataFromDisk():
	print("从磁盘加载角色数据")
	pass


func createCustomer(roleData):
	print("创建角色："+ roleData.get("roleName"))
	var customer : Node2D = Customer.instance()
	layer.add_child(customer)
	customer.global_position = Vector2(-100,500)
	customer.setData(roleData)
	

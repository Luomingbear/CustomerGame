# CustomerGame
Godot 的2D游戏。客服模拟器

## 安装Godot


```shell
brew install --cask godot
```
或者去[官网下载安装](https://godotengine.org/download)



## 数据处理

从CSV中读取对话数据，暂时保存在内存中，保存的格式如下：

```json
[
    {
        "roleName": "101", //角色名
        "isNeedReturnGoods": false, //是否需要退货
        "dialogueIndex": "1001", //默认显示的对话id
        "difficulty":1, //难度
        "dialogMap": { //对话map
            "1001": {
                "text": "你这个东西质量咋样",
                "mood": 0,
                "option1": {
                    "text": "那必须可以",
                    "jump": "1002",
                    "mood": 1
                },
                "option2": {
                    "text": "凑合吧",
                    "jump": "1002",
                    "mood": 2
                },
                "option3": {
                    "text": "滚",
                    "jump": "1003",
                    "mood": 10
                },
                "option4": {
                    "text": "啥玩意啊",
                    "jump": "1003",
                    "mood": 10
                },
                "optionNo": {
                    "text": "",
                    "jump": "1004",
                    "mood": 10
                }
            },
            "1002": {
            }
            ...
        }
    }
]
```

## 对话显示逻辑

游戏里面涉及到玩家和客户，他们都有说话的能力。层级关系如下：

```js
World
----Customer
    |----CustomerDialogue
----Hero
    |----HeroDialogue
----OptionPanel
```

对话框顺序：


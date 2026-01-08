# robosys2025-ROS2-
ロボットシステム学課題2　

## ノード一覧


## トピック一覧
### Publish

| トピック名 | 型 | 説明 |
|---|---|---|
| /countup | std_msgs/msg/Int16 | カウント値 |

## 入出力例
```bash
$ ros2 run mypkg talker
[INFO] [1767859022.473146342] [smart_talker]: SmartTalker started
[INFO] [1767859022.957002387] [smart_talker]: count=0, sensor=0, diff=0
[INFO] [1767859023.457610538] [smart_talker]: count=1, sensor=0, diff=1
[INFO] [1767859023.957033728] [smart_talker]: count=2, sensor=0, diff=2
[INFO] [1767859024.457031415] [smart_talker]: count=3, sensor=0, diff=3
[INFO] [1767859024.957109836] [smart_talker]: count=4, sensor=0, diff=4
[INFO] [1767859025.457021563] [smart_talker]: count=5, sensor=0, diff=5
[INFO] [1767859025.957305497] [smart_talker]: count=6, sensor=0, diff=6
[INFO] [1767859026.457131918] [smart_talker]: count=7, sensor=0, diff=7
[INFO] [1767859026.957422710] [smart_talker]: count=8, sensor=0, diff=8
[INFO] [1767859027.456918934] [smart_talker]: count=9, sensor=0, diff=9
[INFO] [1767859027.957139190] [smart_talker]: count=10, sensor=0, diff=10 
```
## ソフトウェア
- Python
 - テスト済みバージョン: 3.7~3.12

## テスト環境
Ubuntu22.04

## ライセンス
- このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます．
- このパッケージのコードは，下記のスライド(CC-BY-SA 4.0 by Ryuichi Ueda)のものを，本人の許可を得て自身の著作としたものです.
    - [ryuichiueda/slides_marp robosys_2025](https://github.com/ryuichiueda/slides_marp/tree/master/prob_robotics_2025)
- © 2025 Tatsunori Kanno

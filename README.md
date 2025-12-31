# robosys2025-ROS2-
ロボットシステム学課題2　トピックの「沈黙」を検出するROS2パッケージ
指定したトピックが一定時間更新されなかったら警告を出します。
## 実行方法
```bash
$ mkdir -p ~/ros2_ws/src
$ cd ~/ros2_ws/src
$ git clone https://github.com/SY1KT/robosys2025-ROS2-.git
$ cd ~/ros2_ws
$ colcon build --packages-select mypkg
$ source install/setup.bash
 
```
## 入出力例
```bash
$ ros2 run mypkg topic_watchdog
[INFO] [1767190760.863005239] [topic_watchdog]: Watching "/chatter" timeout=1.0s
[WARN] [1767190761.851018981] [topic_watchdog]: WARN: /chatter timeout (1.00s)
[WARN] [1767190762.051026358] [topic_watchdog]: WARN: /chatter timeout (1.20s)
[WARN] [1767190762.251031843] [topic_watchdog]: WARN: /chatter timeout (1.40s)
[WARN] [1767190762.451059284] [topic_watchdog]: WARN: /chatter timeout (1.60s)
[WARN] [1767190762.652511251] [topic_watchdog]: WARN: /chatter timeout (1.80s)
[WARN] [1767190762.851044803] [topic_watchdog]: WARN: /chatter timeout (2.00s)
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

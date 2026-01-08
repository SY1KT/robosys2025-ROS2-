#!/usr/bin/env bash
#SPDX-FileCopyrightText: 2025 Tatsunori Kanno
#SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import Int16, String


class SmartTalker(Node):

    def __init__(self):
        super().__init__('smart_talker')

        # publisher
        self.count_pub = self.create_publisher(Int16, 'countup', 10)
        self.diff_pub = self.create_publisher(Int16, 'diff', 10)
        self.status_pub = self.create_publisher(String, 'status', 10)

        # subscriber
        self.sub = self.create_subscription(
            Int16,
            'sensor_value',
            self.sensor_cb,
            10
        )

        self.timer = self.create_timer(0.5, self.timer_cb)

        self.count = 0
        self.sensor_value = 0

        self.get_logger().info('SmartTalker started')

    def sensor_cb(self, msg):

        self.sensor_value = msg.data

    def timer_cb(self):
        # countup publish
        count_msg = Int16()
        count_msg.data = self.count
        self.count_pub.publish(count_msg)

        # 差分計算
        diff = self.count - self.sensor_value
        diff_msg = Int16()
        diff_msg.data = diff
        self.diff_pub.publish(diff_msg)

        # 状態メッセージ
        status_msg = String()
        if abs(diff) < 5:
            status_msg.data = "SYNC"
        elif diff > 0:
            status_msg.data = "COUNT IS AHEAD"
        else:
            status_msg.data = "SENSOR IS AHEAD"

        self.status_pub.publish(status_msg)

        self.get_logger().info(
            f'count={self.count}, sensor={self.sensor_value}, diff={diff}'
        )

        self.count += 1


def main():
    rclpy.init()
    node = SmartTalker()
    rclpy.spin(node)
    rclpy.shutdown()

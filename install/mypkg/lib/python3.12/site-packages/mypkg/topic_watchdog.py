#!/usr/bin/python3
# SPDX-FileCopyrightText: 2025 Kanno Tatsunori
# SPDX-License-Identifier: BSD-3-Clause

import rclpy
from rclpy.node import Node
from std_msgs.msg import String


class TopicWatchdog(Node):

    def __init__(self):
        super().__init__('topic_watchdog')

        self.declare_parameter('watch_topic', '/chatter')
        self.declare_parameter('timeout_sec', 1.0)

        self.watch_topic = self.get_parameter('watch_topic').value
        self.timeout_sec = self.get_parameter('timeout_sec').value

        self.sub = self.create_subscription(
            String,
            self.watch_topic,
            self.cb,
            10
        )

        self.pub = self.create_publisher(
            String,
            '/watchdog/status',
            10
        )

        self.last_time = self.get_clock().now()
        self.timer = self.create_timer(0.2, self.check)

        self.get_logger().info(
            f'Watching "{self.watch_topic}" timeout={self.timeout_sec}s'
        )

    def cb(self, msg):
        self.last_time = self.get_clock().now()

    def check(self):
        now = self.get_clock().now()
        elapsed = (now - self.last_time).nanoseconds * 1e-9

        msg = String()
        if elapsed > self.timeout_sec:
            msg.data = f'WARN: {self.watch_topic} timeout ({elapsed:.2f}s)'
            self.get_logger().warn(msg.data)
        else:
            msg.data = f'OK: {self.watch_topic} alive'

        self.pub.publish(msg)


def main():
    rclpy.init()
    node = TopicWatchdog()
    rclpy.spin(node)
    rclpy.shutdown()
